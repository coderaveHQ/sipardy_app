-- Add player details to game_room_questions
ALTER TABLE public.game_room_questions
ADD player_position INTEGER;

-- Drop current choose question function
DROP FUNCTION app_choose_question(TEXT, TEXT);

-- Create new choose question function
CREATE OR REPLACE FUNCTION app_choose_question(
    in_room_id TEXT,
    in_question_id TEXT,
    in_player_position INTEGER
)
RETURNS VOID AS $$
BEGIN
    UPDATE game_room_questions
    SET selected = TRUE, player_position = in_player_position
    WHERE room_id = in_room_id AND question_id = in_question_id::UUID;

    UPDATE game_rooms
    SET current_action = 'show_question'::public.game_action
    WHERE id = in_room_id;
END;
$$ LANGUAGE plpgsql;