DELETE FROM public.game_questions;

ALTER TABLE public.game_questions
    RENAME COLUMN question TO question_de;

ALTER TABLE public.game_questions
    RENAME COLUMN answer TO answer_de;

ALTER TABLE public.game_questions
    ADD COLUMN question_en TEXT NOT NULL,
    ADD COLUMN answer_en TEXT NOT NULL;