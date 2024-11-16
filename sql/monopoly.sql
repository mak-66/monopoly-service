	--
	-- This SQL script builds a monopoly database, deleting any pre-existing version.
	--
	-- @author kvlinden
	-- @version Summer, 2015
	-- 
	-- @modified by mak66, 10/26/2024
	-- 


	-- Drop previous versions of the tables if they they exist, in reverse order of foreign keys.
	DROP TABLE IF EXISTS PlayerGameProperty;
	DROP TABLE IF EXISTS PlayerGame;
	DROP TABLE IF EXISTS Game;
	DROP TABLE IF EXISTS Player;

	-- Create the schema.
	CREATE TABLE Game (
		ID integer PRIMARY KEY,
		time timestamp
		);

	CREATE TABLE Player (
		ID integer PRIMARY KEY, 
		emailAddress varchar(50) NOT NULL,
		name varchar(50)
		);

	CREATE TABLE PlayerGame (
		gameID integer REFERENCES Game(ID), 
		playerID integer REFERENCES Player(ID),
		score integer,	
		cash integer,
		pieceLocation varchar(50),
		PRIMARY KEY (gameID, playerID)  -- Define gameID and playerID as a composite primary key, helps prevent deletion of a playergame instance while properties still are associated
		);

	CREATE TABLE PlayerGameProperty ( 
		gameID integer,
		playerID integer,	
		name varchar(50),
		houses integer,
		hotels integer,
		FOREIGN KEY (gameID, playerID) REFERENCES PlayerGame(gameID, playerID)
		);

	-- Allow users to select data from the tables.
	GRANT SELECT ON Game TO PUBLIC;
	GRANT SELECT ON Player TO PUBLIC;
	GRANT SELECT ON PlayerGame TO PUBLIC;
	GRANT SELECT ON PlayerGameProperty TO PUBLIC;

	-- Add sample records.
	INSERT INTO Game VALUES (1, '2006-06-27 08:00:00');
	INSERT INTO Game VALUES (2, '2006-06-28 13:20:00');
	INSERT INTO Game VALUES (3, '2006-06-29 18:41:00');

	INSERT INTO Player(ID, emailAddress) VALUES (1, 'me@calvin.edu');
	INSERT INTO Player VALUES (2, 'king@gmail.edu', 'The King');
	INSERT INTO Player VALUES (3, 'dog@gmail.edu', 'Dogbreath');

	INSERT INTO PlayerGame VALUES (1, 1, 430.00, 430, 'start');
	INSERT INTO PlayerGame VALUES (1, 2, 20.00, 20, 'boardwalk');
	INSERT INTO PlayerGame VALUES (1, 3, 2350.00, 0, 'jail');
	INSERT INTO PlayerGame VALUES (2, 1, 1000.00, 0, 'jail');
	INSERT INTO PlayerGame VALUES (2, 2, 0.00, 0, 'jail');
	INSERT INTO PlayerGame VALUES (2, 3, 500.00, 0, 'jail');
	INSERT INTO PlayerGame VALUES (3, 2, 0.00, 0, 'jail');
	INSERT INTO PlayerGame VALUES (3, 3, 5500.00, 0, 'jail');

	INSERT INTO PlayerGameProperty VALUES (1, 3, 'Boardwalk', 2, 1);
	INSERT INTO PlayerGameProperty VALUES (1, 3, 'Park Place', 3, 0);
	INSERT INTO PlayerGameProperty VALUES (2, 1,'Baltic Avenue', 0, 0);
	INSERT INTO PlayerGameProperty VALUES (2, 3, 'Mediterranean Avenue', 1, 0);
	INSERT INTO PlayerGameProperty VALUES (3, 3, 'Marvin Gardens', 4, 0);
	INSERT INTO PlayerGameProperty VALUES (3, 3, 'Ventnor Avenue', 3, 0);
