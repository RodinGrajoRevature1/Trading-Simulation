DROP TABLE IF EXISTS LikesComments;
DROP TABLE IF EXISTS LikesPosts;
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS Posts;
DROP TABLE IF EXISTS Friends;
DROP TABLE IF EXISTS Buys;
DROP TABLE IF EXISTS Sells;
DROP TABLE IF EXISTS Investments;
DROP TABLE IF EXISTS Portfolios;
DROP TABLE IF EXISTS Profiles;
DROP TABLE IF EXISTS Users;

CREATE TABLE Users
(
	userID NVARCHAR(100) PRIMARY KEY,
	role INT NOT NULL DEFAULT 0,
	dateCreated DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP,
	dateModified DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Profiles
(
	profileID UNIQUEIDENTIFIER PRIMARY KEY NOT NULL DEFAULT newid(), --make sure all the guids have a newid generator
	fk_userID UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Users(userID),
	name NVARCHAR (100) NOT NULL,
	email NVARCHAR (64) NOT NULL,
	privacyLevel INT NOT NULL
);

CREATE TABLE Portfolios
(
	portfolioID UNIQUEIDENTIFIER PRIMARY KEY NOT NULL DEFAULT newid(),
	fk_userID UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Users(userID),
	name NVARCHAR (100) NOT NULL,
	privacyLevel INT NOT NULL,
	type INT NOT NULL DEFAULT 0,
	originalLiquid MONEY NOT NULL,
	currrentInvestment MONEY NOT NULL,
	liquid MONEY NOT NULL,
	currentTotal MONEY NOT NULL,
	symbols INT NOT NULL,
	dateCreated DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP,
	dateModified DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP --use this constraINT for all DATETIME2 columns
);

CREATE TABLE Investments
(
	InvestmentID UNIQUEIDENTIFIER PRIMARY KEY NOT NULL DEFAULT newid(),
	fk_portfolioID UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Portfolios(portfolioID),
	symbol NVARCHAR (20) NOT NULL,
	amountInvested DECIMAL NOT NULL,
	currentAmount DECIMAL NOT NULL,
	currentPrice MONEY NOT NULL,
	totalAmountBought DECIMAL NOT NULL,
	totalAmountSold DECIMAL NOT NULL,
	averageBuyPrice MONEY NOT NULL,
	totalPNL MONEY NOT NULL
);

CREATE TABLE Buys
(
	buyID UNIQUEIDENTIFIER PRIMARY KEY NOT NULL DEFAULT newid(),
	fk_portfolioID UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Portfolios(portfolioID),
	symbol NVARCHAR (20) NOT NULL,
	currentPrice MONEY NOT NULL,
	amountBought DECIMAL NOT NULL,
	priceBought MONEY NOT NULL,
	dateBought DATETIME2 DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Sells
(
	sellID UNIQUEIDENTIFIER PRIMARY KEY NOT NULL DEFAULT newid(),
	fk_portfolioID UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Portfolios(portfolioID),
	symbol NVARCHAR (20) NOT NULL,
	amountSold DECIMAL NOT NULL,
	priceSold MONEY NOT NULL,
	dateSold DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP,
	pnl MONEY NOT NULL
);

CREATE TABLE Friends
(
	friendID UNIQUEIDENTIFIER PRIMARY KEY NOT NULL DEFAULT newid(),
	fk_user1ID UNIQUEIDENTIFIER REFERENCES Users(userID),
	fk_user2ID UNIQUEIDENTIFIER REFERENCES Users(userID),
	dateFriended DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Posts
(
	postID UNIQUEIDENTIFIER PRIMARY KEY NOT NULL DEFAULT newid(),
	fk_userID UNIQUEIDENTIFIER REFERENCES Users(userID),
	title NVARCHAR (100) NOT NULL, --set the conventional limit
	content NVARCHAR (MAX) NOT NULL, --set the conventional limit
	likes INT NOT NULL,
	privacyLevel INT NOT NULL,
	dateCreated DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP,
	dateModified DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Comments
(
	commentID UNIQUEIDENTIFIER PRIMARY KEY NOT NULL DEFAULT newid(),
	fk_userID UNIQUEIDENTIFIER REFERENCES Users(userID),
	fk_postID  UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Posts(postID),
	content NVARCHAR (MAX) NOT NULL, --set the conventional limit (150)
	likes INT NOT NULL,
	dateCreated DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP,
	dateModified DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE LikesPosts
(
	likesPostsID UNIQUEIDENTIFIER PRIMARY KEY NOT NULL DEFAULT newid(),
	fk_postID UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Posts(postID),
	fk_userID  UNIQUEIDENTIFIER REFERENCES Users(userID),
	dateCreated DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP,
	dateModified DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE LikesComments
(
	likesCommentsID UNIQUEIDENTIFIER PRIMARY KEY NOT NULL DEFAULT newid(),
	fk_commentID UNIQUEIDENTIFIER NOT NULL FOREIGN KEY REFERENCES Comments(commentID),
	fk_userID UNIQUEIDENTIFIER REFERENCES Users(userID),
	dateCreated DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP,
	dateModified DATETIME2 NOT NULL DEFAULT CURRENT_TIMESTAMP
);