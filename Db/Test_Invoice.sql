USE [master]
GO
/****** Object:  Database [Test_Invoice]    Script Date: 26/01/2023 19:19:09 ******/
CREATE DATABASE [Test_Invoice]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Test_Invoice', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\Test_Invoice.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Test_Invoice_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER01\MSSQL\DATA\Test_Invoice_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Test_Invoice] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Test_Invoice].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Test_Invoice] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Test_Invoice] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Test_Invoice] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Test_Invoice] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Test_Invoice] SET ARITHABORT OFF 
GO
ALTER DATABASE [Test_Invoice] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Test_Invoice] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Test_Invoice] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Test_Invoice] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Test_Invoice] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Test_Invoice] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Test_Invoice] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Test_Invoice] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Test_Invoice] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Test_Invoice] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Test_Invoice] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Test_Invoice] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Test_Invoice] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Test_Invoice] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Test_Invoice] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Test_Invoice] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Test_Invoice] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Test_Invoice] SET RECOVERY FULL 
GO
ALTER DATABASE [Test_Invoice] SET  MULTI_USER 
GO
ALTER DATABASE [Test_Invoice] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Test_Invoice] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Test_Invoice] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Test_Invoice] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Test_Invoice] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Test_Invoice] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'Test_Invoice', N'ON'
GO
ALTER DATABASE [Test_Invoice] SET QUERY_STORE = ON
GO
ALTER DATABASE [Test_Invoice] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Test_Invoice]
GO
/****** Object:  Table [dbo].[Customers]    Script Date: 26/01/2023 19:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustName] [nvarchar](70) NOT NULL,
	[Adress] [nvarchar](120) NOT NULL,
	[Status] [bit] NOT NULL,
	[CustomerTypeId] [int] NOT NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CustomerTypes]    Script Date: 26/01/2023 19:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CustomerTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Description] [nvarchar](70) NOT NULL,
 CONSTRAINT [PK_CustomerType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[CustomerView]    Script Date: 26/01/2023 19:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE VIEW [dbo].[CustomerView] AS SELECT Customers.Id, Customers.CustName, Customers.Adress as Address,case when Customers.Status = 1 then 'Activo' else 'Inactivo' end AS Status, CustomerTypes.Description AS CustomerType FROM Customers INNER JOIN CustomerTypes ON Customers.CustomerTypeId = CustomerTypes.Id
GO
/****** Object:  Table [dbo].[Invoice]    Script Date: 26/01/2023 19:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[TotalItbis] [money] NOT NULL,
	[SubTotal] [money] NOT NULL,
	[Total] [money] NOT NULL,
 CONSTRAINT [PK_Invoice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InvoiceDetail]    Script Date: 26/01/2023 19:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InvoiceDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[Qty] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[TotalItbis] [money] NOT NULL,
	[SubTotal] [money] NOT NULL,
	[Total] [money] NOT NULL,
 CONSTRAINT [PK_InvoiceDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Customers] ON 

INSERT [dbo].[Customers] ([Id], [CustName], [Adress], [Status], [CustomerTypeId]) VALUES (1, N'Jose Garcia', N'Sector 30 de Mayo #95', 1, 2)
INSERT [dbo].[Customers] ([Id], [CustName], [Adress], [Status], [CustomerTypeId]) VALUES (2, N'Jainer Gonzalez', N'Sector Los Padros #195 Edif. B', 1, 2)
INSERT [dbo].[Customers] ([Id], [CustName], [Adress], [Status], [CustomerTypeId]) VALUES (3, N'Alvaro Perez', N'Sector Coro #85 Edif. B', 1, 1)
INSERT [dbo].[Customers] ([Id], [CustName], [Adress], [Status], [CustomerTypeId]) VALUES (4, N'Pablo Ayala', N'Sector Valencia #100', 0, 1)
INSERT [dbo].[Customers] ([Id], [CustName], [Adress], [Status], [CustomerTypeId]) VALUES (19, N'Pablo Pica', N'Malecon Center', 0, 1)
INSERT [dbo].[Customers] ([Id], [CustName], [Adress], [Status], [CustomerTypeId]) VALUES (21, N'Carlos Martinez', N'C/ del sol No. 132', 1, 2)
INSERT [dbo].[Customers] ([Id], [CustName], [Adress], [Status], [CustomerTypeId]) VALUES (25, N'Luis Antonio', N'Calle lumbral No.43', 1, 2)
INSERT [dbo].[Customers] ([Id], [CustName], [Adress], [Status], [CustomerTypeId]) VALUES (26, N'Petro Caribe', N'Venezuela', 1, 1)
SET IDENTITY_INSERT [dbo].[Customers] OFF
GO
SET IDENTITY_INSERT [dbo].[CustomerTypes] ON 

INSERT [dbo].[CustomerTypes] ([Id], [Description]) VALUES (1, N'Regular')
INSERT [dbo].[CustomerTypes] ([Id], [Description]) VALUES (2, N'Fijo')
SET IDENTITY_INSERT [dbo].[CustomerTypes] OFF
GO
SET IDENTITY_INSERT [dbo].[Invoice] ON 

INSERT [dbo].[Invoice] ([Id], [CustomerId], [TotalItbis], [SubTotal], [Total]) VALUES (1, 1, 18.0000, 1200.0000, 3000.0000)
INSERT [dbo].[Invoice] ([Id], [CustomerId], [TotalItbis], [SubTotal], [Total]) VALUES (2, 1, 43.0000, 35.0000, 545.0000)
INSERT [dbo].[Invoice] ([Id], [CustomerId], [TotalItbis], [SubTotal], [Total]) VALUES (3, 1, 24.0000, 43.0000, 434.0000)
SET IDENTITY_INSERT [dbo].[Invoice] OFF
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF_Customers_Status]  DEFAULT ((1)) FOR [Status]
GO
ALTER TABLE [dbo].[Customers] ADD  CONSTRAINT [DF_Customers_CustomerType]  DEFAULT ((1)) FOR [CustomerTypeId]
GO
ALTER TABLE [dbo].[Invoice] ADD  CONSTRAINT [DF_Invoice_TotalItbis]  DEFAULT ((0)) FOR [TotalItbis]
GO
ALTER TABLE [dbo].[InvoiceDetail] ADD  CONSTRAINT [DF_InvoiceDetail_TotalItbis1]  DEFAULT ((0)) FOR [Qty]
GO
ALTER TABLE [dbo].[InvoiceDetail] ADD  CONSTRAINT [DF_InvoiceDetail_TotalItbis]  DEFAULT ((0)) FOR [TotalItbis]
GO
ALTER TABLE [dbo].[Customers]  WITH CHECK ADD  CONSTRAINT [FK_Customers_CustomerTypes] FOREIGN KEY([CustomerTypeId])
REFERENCES [dbo].[CustomerTypes] ([Id])
ON UPDATE CASCADE
GO
ALTER TABLE [dbo].[Customers] CHECK CONSTRAINT [FK_Customers_CustomerTypes]
GO
ALTER TABLE [dbo].[Invoice]  WITH CHECK ADD  CONSTRAINT [FK_Invoice_Customers] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customers] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Customers]
GO
ALTER TABLE [dbo].[InvoiceDetail]  WITH CHECK ADD  CONSTRAINT [FK_InvoiceDetail_Invoice] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Invoice] ([Id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[InvoiceDetail] CHECK CONSTRAINT [FK_InvoiceDetail_Invoice]
GO
/****** Object:  StoredProcedure [dbo].[sp_customer_insert]    Script Date: 26/01/2023 19:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_customer_insert]
	-- Add the parameters for the stored procedure here
	 @CustName varchar(100),
	 @Address varchar(700),
	 @Status bit,
	 @CustomerType int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON; 

	 insert into Customers (CustName,Adress,Status,CustomerTypeId) values(@CustName,@Address,@Status,@CustomerType);
	  
END
GO
/****** Object:  StoredProcedure [dbo].[sp_customer_update]    Script Date: 26/01/2023 19:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[sp_customer_update]
	-- Add the parameters for the stored procedure here
	 @Id int,
	 @CustName varchar(100),
	 @Address varchar(700),
	 @Status bit,
	 @CustomerType int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON; 

	 update Customers set CustName = @CustName,Adress = @Address,Status = @Status,CustomerTypeId = @CustomerType 
	 where Id = @Id;
	  
END
GO
/****** Object:  StoredProcedure [dbo].[sp_invoice_insert]    Script Date: 26/01/2023 19:19:10 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
create PROCEDURE [dbo].[sp_invoice_insert]
	-- Add the parameters for the stored procedure here
	 @CustomerId int,
	 @TotalItbis decimal,
	 @SubTotal decimal,
	 @Total decimal
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON; 

	 insert into invoice(CustomerId,TotalItbis,SubTotal,Total) values(@CustomerId,@TotalItbis,@SubTotal,@Total);
	  
END
GO
USE [master]
GO
ALTER DATABASE [Test_Invoice] SET  READ_WRITE 
GO
