-- phpMyAdmin SQL Dump
-- version 4.2.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Erstellungszeit: 26. Mrz 2017 um 17:50
-- Server Version: 5.6.21
-- PHP-Version: 5.5.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Datenbank: `gtao_test`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `warps`
--

CREATE TABLE IF NOT EXISTS `warps` (
`id` int(10) unsigned NOT NULL,
  `name` varchar(32) COLLATE utf8_unicode_ci NOT NULL,
  `x` float NOT NULL,
  `y` float NOT NULL,
  `z` float NOT NULL,
  `heading` float NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Daten für Tabelle `warps`
--

INSERT INTO `warps` (`id`, `name`, `x`, `y`, `z`, `heading`) VALUES
(1, 'null', 0, 0, 70, 1);

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `warps`
--
ALTER TABLE `warps`
 ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `warps`
--
ALTER TABLE `warps`
MODIFY `id` int(10) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=4;