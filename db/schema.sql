CREATE TABLE user (
    `user_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(32) NOT NULL,
    `created` TIMESTAMP NOT NULL,
    PRIMARY KEY (user_id),
    UNIQUE KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE diary (
    `diary_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `user` VARCHAR(32) NOT NULL,
    `name` VARCHAR(32) NOT NULL,
    `created` TIMESTAMP NOT NULL,
    PRIMARY KEY (diary_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE entry (
    `entry_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    `diary_id` BIGINT UNSIGNED NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `body` TEXT NOT NULL,
    `created` TIMESTAMP NOT NULL,
    `updated` TIMESTAMP NOT NULL,
    CONSTRAINT `entries_diary_id_fk`
      FOREIGN KEY (`diary_id`)
      REFERENCES `diary` (`diary_id`)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    PRIMARY KEY (entry_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
