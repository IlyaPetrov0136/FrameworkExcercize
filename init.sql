CREATE TABLE IF NOT EXISTS department
(
    department_id SERIAL PRIMARY KEY,
    department_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS direction
(
    direction_id SERIAL PRIMARY KEY,
    direction_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS event_status
(
    event_status_id SERIAL PRIMARY KEY,
    event_status_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS task_status
(
    task_status_id SERIAL PRIMARY KEY,
    task_status_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS participation_status
(
    participation_status_id SERIAL PRIMARY KEY,
    participation_status_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS rank
(
    rank_id SERIAL PRIMARY KEY,
    rank_name TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS "User"
(
    user_id SERIAL PRIMARY KEY,
    direction_id INTEGER NOT NULL,
    department_id INTEGER NOT NULL,

    user_username TEXT NOT NULL,
    user_name TEXT NOT NULL,
    user_lastname TEXT NOT NULL,
    user_patronymic TEXT,
    user_course SMALLINT NOT NULL,
    user_birthdate DATE NOT NULL,
    user_telegram_username TEXT NOT NULL,
    user_join_date DATE NOT NULL,
    user_is_active BOOLEAN NOT NULL,

    login TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL,
    salt TEXT NOT NULL,

    CONSTRAINT fk_user_direction
    FOREIGN KEY (direction_id) REFERENCES direction(direction_id),

    CONSTRAINT fk_user_department
    FOREIGN KEY (department_id) REFERENCES department(department_id)
    );

CREATE TABLE IF NOT EXISTS events
(
    event_id SERIAL PRIMARY KEY,
    department_id INTEGER NOT NULL,
    event_status_id INTEGER NOT NULL,

    event_title TEXT NOT NULL,
    event_description TEXT NOT NULL,
    event_start DATE NOT NULL,
    event_end DATE,
    event_audithory SMALLINT,

    CONSTRAINT fk_events_department
    FOREIGN KEY (department_id) REFERENCES department(department_id),

    CONSTRAINT fk_events_status
    FOREIGN KEY (event_status_id) REFERENCES event_status(event_status_id)
    );

CREATE TABLE IF NOT EXISTS tasks
(
    task_id SERIAL PRIMARY KEY,
    event_id INTEGER NOT NULL,
    task_status_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    task_title TEXT NOT NULL,
    task_description TEXT NOT NULL,

    CONSTRAINT fk_tasks_event
    FOREIGN KEY (event_id) REFERENCES events(event_id),

    CONSTRAINT fk_tasks_status
    FOREIGN KEY (task_status_id) REFERENCES task_status(task_status_id),

    CONSTRAINT fk_tasks_user
    FOREIGN KEY (user_id) REFERENCES "User"(user_id)
    );

CREATE TABLE IF NOT EXISTS task_comments
(
    task_comment_id SERIAL PRIMARY KEY,
    task_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    task_comment_content TEXT NOT NULL,
    task_comment_created_at DATE NOT NULL,

    CONSTRAINT fk_task_comments_task
    FOREIGN KEY (task_id) REFERENCES tasks(task_id),

    CONSTRAINT fk_task_comments_user
    FOREIGN KEY (user_id) REFERENCES "User"(user_id)
    );

CREATE TABLE IF NOT EXISTS participation
(
    participation_id SERIAL PRIMARY KEY,
    event_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,
    participation_status_id INTEGER NOT NULL,

    participation_reason TEXT,
    participation_registered_at DATE NOT NULL,

    CONSTRAINT fk_participation_event
    FOREIGN KEY (event_id) REFERENCES events(event_id),

    CONSTRAINT fk_participation_user
    FOREIGN KEY (user_id) REFERENCES "User"(user_id),

    CONSTRAINT fk_participation_status
    FOREIGN KEY (participation_status_id)
    REFERENCES participation_status(participation_status_id)
    );

CREATE TABLE IF NOT EXISTS user_in_rank
(
    user_rank_id SERIAL PRIMARY KEY,
    rank_id INTEGER NOT NULL,
    user_id INTEGER NOT NULL,

    user_rank_start_date DATE NOT NULL,
    user_rank_end_date DATE,

    CONSTRAINT fk_user_in_rank_rank
    FOREIGN KEY (rank_id) REFERENCES rank(rank_id),

    CONSTRAINT fk_user_in_rank_user
    FOREIGN KEY (user_id) REFERENCES "User"(user_id)
    );
