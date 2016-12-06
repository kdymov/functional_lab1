-- phpMyAdmin SQL Dump
-- version 4.6.1
-- http://www.phpmyadmin.net
--
-- Хост: localhost
-- Время создания: Дек 06 2016 г., 00:04
-- Версия сервера: 5.7.12-log
-- Версия PHP: 5.6.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `hex_lab1`
--

-- --------------------------------------------------------

--
-- Структура таблицы `compclass`
--

CREATE TABLE `compclass` (
  `id` int(11) NOT NULL,
  `name` int(11) NOT NULL,
  `places` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `compclass`
--

INSERT INTO `compclass` (`id`, `name`, `places`) VALUES
(1, 231, 35),
(2, 610, 30),
(3, 204, 10);

-- --------------------------------------------------------

--
-- Структура таблицы `developer`
--

CREATE TABLE `developer` (
  `id` int(11) NOT NULL,
  `name` varchar(40) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `developer`
--

INSERT INTO `developer` (`id`, `name`) VALUES
(1, 'Korovin Avgustin'),
(2, 'Ivanov Varfolomey'),
(4, 'Lopuh Vitaliy'),
(5, 'Kadyrov Ramzan'),
(7, 'Leonov Valeriy');

-- --------------------------------------------------------

--
-- Структура таблицы `schedule`
--

CREATE TABLE `schedule` (
  `id` int(11) NOT NULL,
  `day` varchar(2) COLLATE utf8_unicode_ci NOT NULL,
  `number` int(11) NOT NULL,
  `name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `class_id` int(11) NOT NULL,
  `developer_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `schedule`
--

INSERT INTO `schedule` (`id`, `day`, `number`, `name`, `class_id`, `developer_id`) VALUES
(1, 'MO', 1, 'OOP', 1, 2),
(2, 'TU', 2, 'Functional', 2, 1),
(3, 'WD', 3, 'OOP', 1, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `testing`
--

CREATE TABLE `testing` (
  `testsession_id` int(11) NOT NULL,
  `place_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `testing`
--

INSERT INTO `testing` (`testsession_id`, `place_id`) VALUES
(1, 1),
(1, 2),
(2, 2);

-- --------------------------------------------------------

--
-- Структура таблицы `workplace`
--

CREATE TABLE `workplace` (
  `id` int(11) NOT NULL,
  `number` int(11) NOT NULL,
  `class_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Дамп данных таблицы `workplace`
--

INSERT INTO `workplace` (`id`, `number`, `class_id`) VALUES
(1, 1, 2),
(2, 2, 2),
(3, 1, 1);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `compclass`
--
ALTER TABLE `compclass`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `developer`
--
ALTER TABLE `developer`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `schedule`
--
ALTER TABLE `schedule`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FOREIGHN_CLASS` (`class_id`),
  ADD KEY `FOREIGHN_TEACHER` (`developer_id`);

--
-- Индексы таблицы `testing`
--
ALTER TABLE `testing`
  ADD KEY `FOREIGHN_LECTURE` (`testsession_id`),
  ADD KEY `FOREIGHN_PLACE` (`place_id`);

--
-- Индексы таблицы `workplace`
--
ALTER TABLE `workplace`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FOREIGHN` (`class_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `compclass`
--
ALTER TABLE `compclass`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `developer`
--
ALTER TABLE `developer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;
--
-- AUTO_INCREMENT для таблицы `schedule`
--
ALTER TABLE `schedule`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- AUTO_INCREMENT для таблицы `workplace`
--
ALTER TABLE `workplace`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `schedule`
--
ALTER TABLE `schedule`
  ADD CONSTRAINT `schedule_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `compclass` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `schedule_ibfk_2` FOREIGN KEY (`developer_id`) REFERENCES `developer` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `testing`
--
ALTER TABLE `testing`
  ADD CONSTRAINT `testing_ibfk_1` FOREIGN KEY (`testsession_id`) REFERENCES `schedule` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `testing_ibfk_2` FOREIGN KEY (`place_id`) REFERENCES `workplace` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `workplace`
--
ALTER TABLE `workplace`
  ADD CONSTRAINT `workplace_ibfk_1` FOREIGN KEY (`class_id`) REFERENCES `compclass` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
