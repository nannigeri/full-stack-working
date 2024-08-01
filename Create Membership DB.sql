-- Create AspNetRoleClaims table
CREATE TABLE AspNetRoleClaims (
    Id INT AUTO_INCREMENT NOT NULL,
    RoleId VARCHAR(450) NOT NULL,
    ClaimType TEXT,
    ClaimValue TEXT,
    PRIMARY KEY (Id),
    FOREIGN KEY (RoleId) REFERENCES AspNetRoles (Id) ON DELETE CASCADE
);

-- Create index on RoleId
CREATE INDEX IX_AspNetRoleClaims_RoleId ON AspNetRoleClaims (RoleId);

-- Create AspNetRoles table
CREATE TABLE AspNetRoles (
    Id VARCHAR(450) NOT NULL,
    Name VARCHAR(256),
    NormalizedName VARCHAR(256),
    ConcurrencyStamp TEXT,
    PRIMARY KEY (Id)
);

-- Create unique index on NormalizedName
CREATE UNIQUE INDEX RoleNameIndex ON AspNetRoles (NormalizedName) WHERE (NormalizedName IS NOT NULL);

-- Create AspNetUserClaims table
CREATE TABLE AspNetUserClaims (
    Id INT AUTO_INCREMENT NOT NULL,
    UserId VARCHAR(450) NOT NULL,
    ClaimType TEXT,
    ClaimValue TEXT,
    PRIMARY KEY (Id),
    FOREIGN KEY (UserId) REFERENCES AspNetUsers (Id) ON DELETE CASCADE
);

-- Create index on UserId
CREATE INDEX IX_AspNetUserClaims_UserId ON AspNetUserClaims (UserId);

-- Create AspNetUserLogins table
CREATE TABLE AspNetUserLogins (
    LoginProvider VARCHAR(128) NOT NULL,
    ProviderKey VARCHAR(128) NOT NULL,
    ProviderDisplayName TEXT,
    UserId VARCHAR(450) NOT NULL,
    PRIMARY KEY (LoginProvider, ProviderKey),
    FOREIGN KEY (UserId) REFERENCES AspNetUsers (Id) ON DELETE CASCADE
);

-- Create index on UserId
CREATE INDEX IX_AspNetUserLogins_UserId ON AspNetUserLogins (UserId);

-- Create AspNetUserRoles table
CREATE TABLE AspNetUserRoles (
    UserId VARCHAR(450) NOT NULL,
    RoleId VARCHAR(450) NOT NULL,
    PRIMARY KEY (UserId, RoleId),
    FOREIGN KEY (RoleId) REFERENCES AspNetRoles (Id) ON DELETE CASCADE,
    FOREIGN KEY (UserId) REFERENCES AspNetUsers (Id) ON DELETE CASCADE
);

-- Create index on RoleId
CREATE INDEX IX_AspNetUserRoles_RoleId ON AspNetUserRoles (RoleId);

-- Create AspNetUsers table
CREATE TABLE AspNetUsers (
    Id VARCHAR(450) NOT NULL,
    UserName VARCHAR(256),
    NormalizedUserName VARCHAR(256),
    Email VARCHAR(256),
    NormalizedEmail VARCHAR(256),
    EmailConfirmed BIT NOT NULL,
    PasswordHash TEXT,
    SecurityStamp TEXT,
    ConcurrencyStamp TEXT,
    PhoneNumber TEXT,
    PhoneNumberConfirmed BIT NOT NULL,
    TwoFactorEnabled BIT NOT NULL,
    LockoutEnd DATETIME,
    LockoutEnabled BIT NOT NULL,
    AccessFailedCount INT NOT NULL,
    PRIMARY KEY (Id)
);

-- Create index on NormalizedEmail
CREATE INDEX EmailIndex ON AspNetUsers (NormalizedEmail);

-- Create unique index on NormalizedUserName
CREATE UNIQUE INDEX UserNameIndex ON AspNetUsers (NormalizedUserName) WHERE (NormalizedUserName IS NOT NULL);

-- Create AspNetUserTokens table
CREATE TABLE AspNetUserTokens (
    UserId VARCHAR(450) NOT NULL,
    LoginProvider VARCHAR(128) NOT NULL,
    Name VARCHAR(128) NOT NULL,
    Value TEXT,
    PRIMARY KEY (UserId, LoginProvider, Name),
    FOREIGN KEY (UserId) REFERENCES AspNetUsers (Id) ON DELETE CASCADE
);
