-- [FUNCTION] to create a new game room
CREATE OR REPLACE FUNCTION app_create_game_room(
    selected_categories TEXT[],
    player_names TEXT[]
)
RETURNS TEXT AS $$
DECLARE
    new_room_id TEXT;
    q_id UUID;
    curr_player_name TEXT;
    selected_category TEXT;
    curr_points INTEGER;
    first_player TEXT;
    player_position INTEGER := 1;
BEGIN
    -- Create a new game room
    INSERT INTO public.game_rooms DEFAULT VALUES RETURNING id INTO new_room_id;

    -- Assign questions to the room
    FOREACH selected_category IN ARRAY selected_categories LOOP
        FOR curr_points IN 1..5 LOOP
            SELECT id
            FROM public.game_questions
            WHERE game_questions.category = selected_category::public.game_category AND game_questions.points = curr_points
            ORDER BY random()
            LIMIT 1
            INTO q_id;
            
            -- Insert the question into game_room_questions table
            INSERT INTO public.game_room_questions (room_id, question_id)
            VALUES (new_room_id, q_id);
        END LOOP;
    END LOOP;

    -- Add players to the room with position
    FOREACH curr_player_name IN ARRAY player_names LOOP
        INSERT INTO public.game_room_players (position, room_id, name, has_turn)
        VALUES (player_position, new_room_id, curr_player_name, player_position = 1);

        -- Increment the position counter
        player_position := player_position + 1;
    END LOOP;

    -- Return the newly created room ID
    RETURN new_room_id;
END;
$$ LANGUAGE plpgsql;

-- [FUNCTION] to update the selected question
CREATE OR REPLACE FUNCTION app_choose_question(
    in_room_id TEXT,
    in_question_id TEXT
)
RETURNS VOID AS $$
BEGIN
    UPDATE game_room_questions
    SET selected = TRUE
    WHERE room_id = in_room_id AND question_id = in_question_id::UUID;

    UPDATE game_rooms
    SET current_action = 'show_question'::public.game_action
    WHERE id = in_room_id;
END;
$$ LANGUAGE plpgsql;

-- [FUNCTION] to show answer to currently selected question
CREATE OR REPLACE FUNCTION app_show_answer(
    in_room_id TEXT
)
RETURNS VOID AS $$
BEGIN
    UPDATE game_rooms
    SET current_action = 'show_answer'::public.game_action
    WHERE id = in_room_id;
END;
$$ LANGUAGE plpgsql;

-- [FUNCTION] to answer the currently selected question
CREATE OR REPLACE FUNCTION app_answer(
    in_room_id TEXT,
    in_correct BOOLEAN
)
RETURNS VOID AS $$
DECLARE
    temp_question_id UUID;
    temp_points INTEGER;
    temp_player_position INTEGER;
    max_player_position INTEGER;
    next_player_position INTEGER;
BEGIN
    -- Save a reference to the question that is currently being answered
    SELECT game_room_questions.question_id 
    INTO temp_question_id 
    FROM game_room_questions 
    WHERE room_id = in_room_id AND selected = TRUE;

    -- Update this question to be not selected anymore and answered
    UPDATE game_room_questions
    SET selected = FALSE, answer = in_correct
    WHERE room_id = in_room_id AND question_id = temp_question_id;

    -- Save the points that the answered question would give
    SELECT game_questions.points 
    INTO temp_points 
    FROM game_questions 
    WHERE id = temp_question_id;

    -- Save a reference to the id / position of the player whose turn it is currently
    SELECT game_room_players.position 
    INTO temp_player_position
    FROM game_room_players 
    WHERE room_id = in_room_id AND has_turn = TRUE;

    -- Update this player by increasing or decreasing the points
    UPDATE game_room_players
    SET 
        points = points + (
            CASE 
                WHEN in_correct = TRUE THEN temp_points
                ELSE -temp_points
            END
        ),
        has_turn = FALSE
    WHERE 
        position = temp_player_position;

    -- Determine the maximum position in the room
    SELECT MAX(position) 
    INTO max_player_position 
    FROM game_room_players 
    WHERE room_id = in_room_id;

    -- Determine the next player position, wrapping around if necessary
    next_player_position := CASE 
        WHEN temp_player_position = max_player_position THEN 1
        ELSE temp_player_position + 1
    END;

    UPDATE game_room_players
    SET has_turn = TRUE
    WHERE room_id = in_room_id AND position = next_player_position;

    -- Update the rooms current action to be "choose the next question you would like to answer"
    UPDATE game_rooms
    SET current_action = 'choose'::public.game_action
    WHERE id = in_room_id;
END;
$$ LANGUAGE plpgsql;