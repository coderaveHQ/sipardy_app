-- [ENUM] for the available game actions
CREATE TYPE public.game_action AS ENUM (
    'choose',
    'show_question',
    'show_answer'
);
