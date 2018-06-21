--
-- Table structure for table `news_news`
--

CREATE TABLE `news_news` (
  `id` int(11) NOT NULL,
  `time` varchar(60) DEFAULT NULL,
  `editor_name` varchar(40) DEFAULT NULL,
  `header` varchar(60) DEFAULT NULL,
  `body` varchar(500) DEFAULT NULL,
  `header2` varchar(60) NOT NULL,
  `body2` varchar(500) NOT NULL,
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `news_news`
--

INSERT INTO `news_news` (`id`, `time`, `editor_name`, `header`, `body`, `header2`, `body2`, `notes`) VALUES
(1, 'Test', 'Test', 'Test', 'Test', 'Test', 'Test', NULL),
(2, 'Thursday 6/21/2018 @ 8:56AM', 'Kole Huey', 'Locals gone wild', 'Recently it has been seen that locals have been driving recklessly in a act to show that local lives matter. Be careful on the road.', 'Cookie Crumbles', 'Last night a police chase ended in a violent shootout between the authorities and what seemed to be a cookie \"man\".', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `news_news`
--
ALTER TABLE `news_news`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `news_news`
--
ALTER TABLE `news_news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `character_id` int(11) DEFAULT NULL,
  `rank` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `character_id`, `rank`) VALUES
(6, 9, 'journalist');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_character_id_police` (`character_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;