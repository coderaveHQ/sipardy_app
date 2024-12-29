-- [SEQUENCE] for the game room IDs
CREATE SEQUENCE public.game_room_id_sequence START 0 MINVALUE 0 MAXVALUE 9999 CYCLE;

-- [FUNCTION] to generate a new game room ID
CREATE OR REPLACE FUNCTION gen_room_id()
RETURNS TEXT AS $$
DECLARE
    new_id TEXT;
BEGIN
    LOOP
        -- Get next value from the sequence and pad it with zeros
        new_id := LPAD(nextval('game_room_id_sequence')::TEXT, 4, '0');
        
        -- Check if the ID is not already in use
        IF NOT EXISTS (SELECT 1 FROM public.game_rooms WHERE id = new_id) THEN
            RETURN new_id;
        END IF;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- [TABLE] for the game rooms
CREATE TABLE public.game_rooms (
    id TEXT NOT NULL DEFAULT gen_room_id(),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    current_action public.game_action NOT NULL DEFAULT 'choose'::public.game_action,
    CONSTRAINT game_rooms_pkey PRIMARY KEY (id)
) TABLESPACE pg_default;

-- [COMMENT] on game_rooms
COMMENT ON TABLE public.game_rooms IS 'The game rooms.';

-- Enable RLS for game_rooms
ALTER TABLE public.game_rooms ENABLE ROW LEVEL SECURITY;

-- [REALTIME] for game_rooms
ALTER publication supabase_realtime ADD TABLE game_rooms;

-- [POLICY] Allow inserts to everyone
CREATE POLICY "public_game_rooms_insert" ON "public"."game_rooms" FOR
INSERT WITH CHECK (true);

-- [POLICY] Allow selects to everyone
CREATE POLICY "public_game_rooms_select" ON "public"."game_rooms" FOR
SELECT USING (true);

-- [POLICY] Allow updates to everyone
CREATE POLICY "public_game_rooms_update" ON "public"."game_rooms" FOR
UPDATE USING (true);

-- [TRIGGER] to update the updated_at timestamp
CREATE TRIGGER update_game_rooms_updated_at_trigger
AFTER UPDATE ON public.game_rooms
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

-- [EXTENSION] pg_cron
CREATE EXTENSION pg_cron;

-- [FUNCTION] to delete inactive game rooms
CREATE OR REPLACE FUNCTION delete_inactive_game_rooms()
RETURNS void AS $$
BEGIN
    DELETE FROM public.game_rooms
    WHERE updated_at < NOW() - INTERVAL '2 hours';
END;
$$ LANGUAGE plpgsql;

-- [CRON JOB] to delete inactive game rooms every hour
SELECT cron.schedule('delete_old_game_rooms', '0 * * * *', 'SELECT delete_inactive_game_rooms();');

-- [TABLE] for the game room players
CREATE TABLE public.game_room_players (
    position INTEGER NOT NULL,
    room_id TEXT NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    name TEXT NOT NULL,
    points INTEGER NOT NULL DEFAULT 0,
    has_turn BOOLEAN NOT NULL,
    CONSTRAINT game_room_players_pkey PRIMARY KEY (position, room_id),
    CONSTRAINT game_room_players_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.game_rooms (id) ON UPDATE CASCADE ON DELETE CASCADE
) TABLESPACE pg_default;

-- [COMMENT] on game_room_players
COMMENT ON TABLE public.game_room_players IS 'The game room players.';

-- Enable RLS for game_room_players
ALTER TABLE public.game_room_players ENABLE ROW LEVEL SECURITY;

-- [REALTIME] for game_room_players
ALTER publication supabase_realtime ADD TABLE game_room_players;

-- [TRIGGER] to update the updated_at timestamp
CREATE TRIGGER update_game_room_players_updated_at_trigger
AFTER UPDATE ON public.game_room_players
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

-- [POLICY] Allow inserts to everyone
CREATE POLICY "public_game_room_players_insert" ON "public"."game_room_players" FOR
INSERT WITH CHECK (true);

-- [POLICY] Allow selects to everyone
CREATE POLICY "public_game_room_players_select" ON "public"."game_room_players" FOR
SELECT USING (true);

-- [POLICY] Allow updates to everyone
CREATE POLICY "public_game_room_players_update" ON "public"."game_room_players" FOR
UPDATE USING (true);

-- [TABLE] for the game room questions
CREATE TABLE public.game_room_questions (
    room_id TEXT NOT NULL,
    question_id UUID NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    selected BOOLEAN NOT NULL DEFAULT FALSE,
    answer BOOLEAN,
    CONSTRAINT game_room_questions_pkey PRIMARY KEY (room_id, question_id),
    CONSTRAINT game_room_questions_pkey_room_id_fkey FOREIGN KEY (room_id) REFERENCES public.game_rooms (id) ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT game_room_questions_pkey_question_id_fkey FOREIGN KEY (question_id) REFERENCES public.game_questions (id) ON UPDATE CASCADE ON DELETE CASCADE
) TABLESPACE pg_default;

-- [COMMENT] on game_room_questions
COMMENT ON TABLE public.game_room_questions IS 'The game room questions.';

-- Enable RLS for game_room_questions
ALTER TABLE public.game_room_questions ENABLE ROW LEVEL SECURITY;

-- [REALTIME] for game_room_questions
ALTER publication supabase_realtime ADD TABLE game_room_questions;

-- [TRIGGER] to update the updated_at timestamp
CREATE TRIGGER update_game_room_questions_updated_at_trigger
AFTER UPDATE ON public.game_room_questions
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

-- [POLICY] Allow inserts to everyone
CREATE POLICY "public_game_room_questions_insert" ON "public"."game_room_questions" FOR
INSERT WITH CHECK (true);

-- [POLICY] Allow selects to everyone
CREATE POLICY "public_game_room_questions_select" ON "public"."game_room_questions" FOR
SELECT USING (true);

-- [POLICY] Allow updates to everyone
CREATE POLICY "public_game_room_questions_update" ON "public"."game_room_questions" FOR
UPDATE USING (true);