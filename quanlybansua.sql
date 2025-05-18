USE [master]
GO

-- Tạo database mới (phiên bản đơn giản)
CREATE DATABASE [quanlybansua]
GO

-- Chuyển sang sử dụng database vừa tạo
USE [quanlybansua]
GO

-- Script tạo bảng dựa trên ERD và đối chiếu kiểu dữ liệu với script QuanLyBanGiay.sql

-- Bảng: Category
CREATE TABLE [dbo].[Category](
	[cid] [int] NOT NULL,
	[cname] [nvarchar](50) NULL,
 CONSTRAINT [PK_Category_quanlybansuaERD] PRIMARY KEY CLUSTERED 
(
	[cid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Bảng: Account
CREATE TABLE [dbo].[Account](
	[uID] [int] IDENTITY(1,1) NOT NULL,
	[user] [nchar](10) NULL,
	[pass] [nchar](10) NULL,
	[isAdmin] [bit] NULL,
	[email] [nvarchar](50) NULL,
 CONSTRAINT [PK_Account_quanlybansuaERD] PRIMARY KEY CLUSTERED 
(
	[uID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Bảng: Product
CREATE TABLE [dbo].[Product](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [nvarchar](200) NULL,
	[image] [nvarchar](500) NULL,
	[price] [float] NULL,
	[brand] [nvarchar](500) NULL, 
	[description] [nvarchar](max) NULL,
	[cateID] [int] NOT NULL,
	[image2] [nvarchar](500) NULL,
	[image3] [nvarchar](500) NULL,
 CONSTRAINT [PK_Product_quanlybansuaERD] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

-- Bảng: Discount
CREATE TABLE [dbo].[Discount](
	[discount_id] [int] IDENTITY(1,1) NOT NULL,
	[discount_value] [decimal](10, 2) NULL,
	[start_date] [date] NULL,
	[end_date] [date] NULL,
    [id_product] [int] NULL, 
 CONSTRAINT [PK_Discount_quanlybansuaERD] PRIMARY KEY CLUSTERED 
(
	[discount_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Bảng: Customer (Thay đổi customer_id làm PK và FK, xóa account_id)
CREATE TABLE [dbo].[Customer](
	[customer_id] [int] NOT NULL, -- Không còn là IDENTITY, sẽ lấy giá trị từ Account.uID
	[full_name] [nvarchar](255) NULL,
    [address] [nvarchar](500) NULL, 
    [province] [nvarchar](100) NULL, 
    -- [account_id] [int] NULL, -- ĐÃ XÓA
 CONSTRAINT [PK_Customer_quanlybansuaERD] PRIMARY KEY CLUSTERED 
(
	[customer_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Bảng: Warehouse
CREATE TABLE [dbo].[Warehouse](
	[product_id] [int] NOT NULL,
	[stock_quantity] [int] NULL,
	[location] [nvarchar](100) NULL,
	[last_updated_date] [date] NULL,
 CONSTRAINT [PK_Warehouse_quanlybansuaERD] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Bảng: Cart (Xóa trường size)
CREATE TABLE [dbo].[Cart](
	[accountID] [int] NOT NULL,
	[productID] [int] NOT NULL,
	[amount] [int] NULL,
	[maCart] [int] IDENTITY(1,1) NOT NULL,
	-- [size] [nvarchar](50) NULL, -- ĐÃ XÓA
 CONSTRAINT [PK_Cart_quanlybansuaERD] PRIMARY KEY CLUSTERED 
(
	[maCart] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Bảng: Review
CREATE TABLE [dbo].[Review](
	[accountID] [int] NULL,
	[productID] [int] NULL,
	[contentReview] [nvarchar](500) NULL,
	[dateReview] [date] NULL,
	[maReview] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Review_quanlybansuaERD] PRIMARY KEY CLUSTERED 
(
	[maReview] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

-- Bảng: SoLuongDaBan
CREATE TABLE [dbo].[SoLuongDaBan](
	[productID] [int] NULL,
	[soLuongDaBan] [int] NULL
) ON [PRIMARY]
GO

-- Bảng: Invoice
CREATE TABLE [dbo].[Invoice](
	[maHD] [int] IDENTITY(1,1) NOT NULL,
	[accountID] [int] NULL,
	[tongGia] [float] NULL,
	[ngayXuat] [datetime] NULL,
 CONSTRAINT [PK_Invoice_quanlybansuaERD] PRIMARY KEY CLUSTERED 
(
	[maHD] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


-- Định nghĩa Foreign Keys

ALTER TABLE [dbo].[Product] WITH CHECK ADD CONSTRAINT [FK_Product_Category_quanlybansuaERD] FOREIGN KEY([cateID])
REFERENCES [dbo].[Category] ([cid])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category_quanlybansuaERD]
GO

ALTER TABLE [dbo].[Discount] WITH CHECK ADD CONSTRAINT [FK_Discount_Product_quanlybansuaERD] FOREIGN KEY([id_product])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[Discount] CHECK CONSTRAINT [FK_Discount_Product_quanlybansuaERD]
GO

-- Customer.customer_id giờ đây tham chiếu đến Account.uID
ALTER TABLE [dbo].[Customer] WITH CHECK ADD CONSTRAINT [FK_Customer_Account_quanlybansuaERD] FOREIGN KEY([customer_id])
REFERENCES [dbo].[Account] ([uID])
GO
ALTER TABLE [dbo].[Customer] CHECK CONSTRAINT [FK_Customer_Account_quanlybansuaERD]
GO

ALTER TABLE [dbo].[Warehouse] WITH CHECK ADD CONSTRAINT [FK_Warehouse_Product_quanlybansuaERD] FOREIGN KEY([product_id])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[Warehouse] CHECK CONSTRAINT [FK_Warehouse_Product_quanlybansuaERD]
GO

ALTER TABLE [dbo].[Cart] WITH CHECK ADD CONSTRAINT [FK_Cart_Account_quanlybansuaERD] FOREIGN KEY([accountID])
REFERENCES [dbo].[Account] ([uID])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Account_quanlybansuaERD]
GO

ALTER TABLE [dbo].[Cart] WITH CHECK ADD CONSTRAINT [FK_Cart_Product_quanlybansuaERD] FOREIGN KEY([productID])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[Cart] CHECK CONSTRAINT [FK_Cart_Product_quanlybansuaERD]
GO

ALTER TABLE [dbo].[Review] WITH CHECK ADD CONSTRAINT [FK_Review_Account_quanlybansuaERD] FOREIGN KEY([accountID])
REFERENCES [dbo].[Account] ([uID])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Account_quanlybansuaERD]
GO

ALTER TABLE [dbo].[Review] WITH CHECK ADD CONSTRAINT [FK_Review_Product_quanlybansuaERD] FOREIGN KEY([productID])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[Review] CHECK CONSTRAINT [FK_Review_Product_quanlybansuaERD]
GO

ALTER TABLE [dbo].[SoLuongDaBan] WITH CHECK ADD CONSTRAINT [FK_SoLuongDaBan_Product_quanlybansuaERD] FOREIGN KEY([productID])
REFERENCES [dbo].[Product] ([id])
GO
ALTER TABLE [dbo].[SoLuongDaBan] CHECK CONSTRAINT [FK_SoLuongDaBan_Product_quanlybansuaERD]
GO

ALTER TABLE [dbo].[Invoice] WITH CHECK ADD CONSTRAINT [FK_Invoice_Account_quanlybansuaERD] FOREIGN KEY([accountID])
REFERENCES [dbo].[Account] ([uID])
GO
ALTER TABLE [dbo].[Invoice] CHECK CONSTRAINT [FK_Invoice_Account_quanlybansuaERD]
GO

-- Trigger để ngăn chặn việc liên kết Customer với Account là Admin
-- Cập nhật trigger để sử dụng customer_id thay vì account_id (đã bị xóa)
CREATE TRIGGER [dbo].[TR_Customer_PreventAdminAsCustomer]
ON [dbo].[Customer]
AFTER INSERT, UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (
        SELECT 1
        FROM inserted i 
        INNER JOIN [dbo].[Account] a ON i.customer_id = a.uID -- Thay i.account_id bằng i.customer_id
        WHERE a.isAdmin = 1 -- Không cần "AND i.customer_id IS NOT NULL" vì customer_id là PK, không thể NULL
    )
    BEGIN
        RAISERROR ('Không thể liên kết hoặc tạo hồ sơ khách hàng cho một tài khoản quản trị viên.', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END
END
GO



USE [quanlybansua] -- Đã thay đổi tên database
GO

-- Chèn dữ liệu cho bảng Account
-- Đã loại bỏ cột isSell không có trong cấu trúc mới
SET IDENTITY_INSERT [dbo].[Account] ON
GO
INSERT [dbo].[Account] ([uID], [user], [pass], [isAdmin], [email]) VALUES (1, N'admin     ', N'123456    ', 1, N'admin123@example.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isAdmin], [email]) VALUES (2, N'abc       ', N'123456    ', 0, N'huynhminhduc01082001@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isAdmin], [email]) VALUES (3, N'songoky   ', N'123456    ', 0, N'huynhminhduc01082001@gmail.com') -- Giả định isSell = 0 tương ứng với isAdmin = 0 cho user thường
INSERT [dbo].[Account] ([uID], [user], [pass], [isAdmin], [email]) VALUES (6, N'mrd       ', N'123       ', 1, N'huynhminhduc01082001@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isAdmin], [email]) VALUES (1014, N'naruto    ', N'123456    ', 1, N'naruto@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isAdmin], [email]) VALUES (1015, N'sasuke    ', N'123456    ', 1, N'sasuke@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isAdmin], [email]) VALUES (1016, N'sakura    ', N'123456    ', 1, N'sasuke@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isAdmin], [email]) VALUES (1017, N'itachi    ', N'123456    ', 1, N'sasuke@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isAdmin], [email]) VALUES (1018, N'kakashi   ', N'123456    ', 1, N'kakashi@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isAdmin], [email]) VALUES (1019, N'jiraiya   ', N'123456    ', 1, N'kakashi@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isAdmin], [email]) VALUES (1022, N'hoang     ', N'1234567   ', 0, N'thaihoangqh123@gmail.com')
INSERT [dbo].[Account] ([uID], [user], [pass], [isAdmin], [email]) VALUES (1023, N'trong     ', N'1         ', 0, N'trong@gmail.com')
GO
SET IDENTITY_INSERT [dbo].[Account] OFF
GO

-- Chèn dữ liệu cho bảng Category
INSERT [dbo].[Category] ([cid], [cname]) VALUES (1, N'Sữa bột')
INSERT [dbo].[Category] ([cid], [cname]) VALUES (2, N'Sữa tươi')
INSERT [dbo].[Category] ([cid], [cname]) VALUES (3, N'Sữa chua')
GO

-- Chèn dữ liệu cho bảng Product
-- Đã thay thế các cột: title -> brand
-- Đã loại bỏ các cột: sell_ID, model, color, delivery, image4 không có trong cấu trúc mới
SET IDENTITY_INSERT [dbo].[Product] ON
GO
INSERT [dbo].[Product] ([id], [name], [image], [price], [brand], [description], [cateID], [image2], [image3]) VALUES (47, N'Sữa bột Lacsure 800g', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/lac800.png?v=1731656026840', 788000, N'OPKO Health', N'LACSURE 800g là sản phẩm của tập đoàn OPKO Health Hoa Kỳ. Được nhập khẩu nguyên hộp từ Tây Ban Nha. Công thức được nghiên cứu bởi các chuyên gia hàng đầu dinh dưỡng tại Châu Âu. Lacsure là thực phẩm bổ sung cao năng lượng dành cho người trưởng thành, trung niên, người cao tuổi, người bệnh cần phục hồi sức khỏe, người có nhu cầu bổ sung dinh dưỡng.', 1, N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/thong-tin-dinh-duong-a9b3d04d-f550-4c0b-85c1-59f6bd4fbe31.png?v=1731656026840', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/z5859393123981-b07f1fb715522e4450694efa66a10bcf-6fd102c8-99e5-44a9-b6fe-702754a838c6.jpg?v=1731656019127')
INSERT [dbo].[Product] ([id], [name], [image], [price], [brand], [description], [cateID], [image2], [image3]) VALUES (48, N'Sữa bột Lacsure 400g', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/lac400.png?v=1731655997527', 398000, N'OPKO Health', N'LACSURE 400g là sản phẩm của tập đoàn OPKO Health Hoa Kỳ. Được nhập khẩu nguyên hộp từ Tây Ban Nha. Công thức được nghiên cứu bởi các chuyên gia hàng đầu dinh dưỡng tại Châu Âu. Lacsure là thực phẩm bổ sung cao năng lượng dành cho người trưởng thành, trung niên, người cao tuổi, người bệnh cần phục hồi sức khỏe, người có nhu cầu bổ sung dinh dưỡng.', 1, N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/thong-tin-dinh-duong.png?v=1731655997527', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/z5859393123981-b07f1fb715522e4450694efa66a10bcf-ac481373-d7d6-4e46-938c-a76c7884428e.jpg?v=1731655997527')
INSERT [dbo].[Product] ([id], [name], [image], [price], [brand], [description], [cateID], [image2], [image3]) VALUES (49, N'SỮA BỘT NAN Expert Pro 380g', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/nan-expert-380g-1a2d8cb2-c9be-462e-9d9b-eadba9526e5c.jpg?v=1694068865303', 203000, N'Nestle', N'Sữa bột Nestle NAN EXPERT PRO 380g là dòng sản phẩm sữa công thức dinh dưỡng từ Thụy Sĩ dành riêng cho trẻ tiêu chảy và bất dung nạp đường Lactose trong giai đoạn từ 0-3 tuổi của thương hiệu nổi tiếng Nestle. Xuất xứ: Hà Lan', 1, N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/nan-expert-380g-2-b248157b-7058-440f-930f-f7fe59029b87.jpg?v=1694068866687', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/nan-expert-380g-1-9ff4fa7b-c3d1-4d8d-a988-36252710481f.jpg?v=1694068867950') -- image4 đã bị loại bỏ
INSERT [dbo].[Product] ([id], [name], [image], [price], [brand], [description], [cateID], [image2], [image3]) VALUES (50, N'Sữa bột công thức Nestle PreNan 380g', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/prenan.jpg?v=1694068951913', 223000, N'Nestle', N'Sữa bột công thức Nestle PreNan 380g đến từ thương hiệu Nestle là công thức đặc chế giúp cung cấp lượng chất dinh dưỡng hợp lý đáp ứng nhu cầu tăng trưởng nhanh của trẻ nhẹ cân hoặc thiếu tháng từ lúc mới sinh cho đến khi trẻ được 5kg. Sữa mang đến nguồn đạm Whey cùng chất béo MCT dễ hấp thu, phù hợp với hệ tiêu hóa non nớt của bé, cung cấp nguồn năng lượng dồi dào và cần thiết cho sự tăng trưởng về thể chất, cân nặng. Thành phần dinh dưỡng trong Pre Nan còn bổ sung DHA, ARA hỗ trợ sự phát triển tốt hơn về trí não và thị giác cho bé ngay trong giai đoạn đầu đời.', 1, N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/prenan-1.jpg?v=1694068953507', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/prenan-2.jpg?v=1694068954623') -- image4 đã bị loại bỏ
INSERT [dbo].[Product] ([id], [name], [image], [price], [brand], [description], [cateID], [image2], [image3]) VALUES (51, N'Sữa bột Nan Optipro Plus 4 1500g hàng nhập khẩu sản xuất tại Singapore', N'https://bizweb.dktcdn.net/thumb/medium/100/416/540/products/456-cc7e2d5a-07ea-43ed-8a4e-64899d40b55f.png?v=1728890491513', 759000, N'Nestle', N'Sữa bột Nan Optipro Plus 4 1500g dành cho bé từ 2-6 tuổi. Thấu hiểu tâm lý của mẹ luôn muốn kiếm tìm những sản phẩm tốt nhất cho con, với kinh nghiệm 155 năm trong phát triển dưỡng nhi, Nestlé cho ra đời dòng sản phẩm sữa NAN OPTIPRO PLUS giúp hỗ trợ tiêu hóa, tăng cường đề kháng và phát triển thể chất & trí não nhờ: phức hợp 5HMO, 100 triệu lợi khuẩn Bifidus BL, đạm chất lượng Optipro, DHA/ARA, Canxi & Vitamin D. Sản phẩm với công thức mới đột phá từ Thuỵ Sĩ, nhập khẩu chính hãng bởi Nestlé Việt Nam được kiểm tra nghiêm ngặt về chất lượng và an toàn sản phẩm của Nestlé toàn cầu.', 1, N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/123-0ae22cfa-1488-4ac7-b3ec-5a52b6569e58.png?v=1728890493743', N'https://bizweb.dktcdn.net/thumb/medium/100/416/540/products/234-eb3e30d7-b6ca-4643-b85a-5043d0c5cca6.png?v=1728890493743') -- image4 đã bị loại bỏ
INSERT [dbo].[Product] ([id], [name], [image], [price], [brand], [description], [cateID], [image2], [image3]) VALUES (52, N'Sữa bột dinh dưỡng Varna Complete Lon 850g', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/416/540/products/varna-xanh.jpg?v=1695716701547', 546000, N'Nutifood', N'Sữa bột Nutifood Varna Complete 850g với công thức FRP (Fast Recovery và Prevention) chuyên biệt giúp phòng ngừa suy giảm sức khỏe khi lớn tuổi và phục hồi sức khỏe nhanh. Sữa bột Nutifood Varna Complete 850g với công thức đặc chế dưới sự giám sát của Viện Nghiên Cứu Dinh Dưỡng NutiFood Thụy Điển – NNRIS có chỉ số GI thấp (GI = 269) giúp ổn định đường huyết tốt cho tim mạch và tăng cường sức đề kháng.', 1, N'https://bizweb.dktcdn.net/thumb/medium/100/416/540/products/varna-xanh-1.jpg?v=1695716702663', N'https://bizweb.dktcdn.net/thumb/medium/100/416/540/products/z4335347645653-17469517a3134b27121d57a4401917f7.jpg?v=1695716702663')
GO
SET IDENTITY_INSERT [dbo].[Product] OFF
GO

-- Chèn dữ liệu cho bảng Cart
-- Đã loại bỏ cột size không có trong cấu trúc mới
SET IDENTITY_INSERT [dbo].[Cart] ON
GO
INSERT [dbo].[Cart] ([accountID], [productID], [amount], [maCart]) VALUES (1, 47, 1, 36)
INSERT [dbo].[Cart] ([accountID], [productID], [amount], [maCart]) VALUES (1022, 47, 1, 38)
GO
SET IDENTITY_INSERT [dbo].[Cart] OFF
GO

-- Chèn dữ liệu cho bảng Invoice
SET IDENTITY_INSERT [dbo].[Invoice] ON
GO
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (1, 1, 999, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (2, 1, 800, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (3, 1, 400, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (4, 1, 511.2, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (5, 1, 241.20000000000002, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (6, 1, 392.40000000000003, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (7, 1, 482.40000000000003, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (8, 2, 300, CAST(N'2021-11-18T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (9, 2, 400, CAST(N'2021-11-17T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (10, 1, 180, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (11, 1, 1079.1000000000001, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (12, 1, 122.4, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (13, 1, 1394.1000000000001, CAST(N'2021-11-20T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (14, 2, 256, CAST(N'2021-10-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (15, 3, 450, CAST(N'2021-10-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (16, 2, 200, CAST(N'2021-09-05T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (17, 2, 100, CAST(N'2021-08-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (18, 3, 156, CAST(N'2021-07-07T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (19, 3, 256, CAST(N'2021-06-06T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (20, 3, 158, CAST(N'2021-05-05T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (21, 2, 800, CAST(N'2021-04-04T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (22, 3, 750, CAST(N'2021-03-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (23, 2, 657, CAST(N'2021-02-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (24, 1, 800, CAST(N'2021-01-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (25, 1, 1491.6, CAST(N'2021-11-25T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (26, 1, 396, CAST(N'2021-11-26T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (27, 1, 761.2, CAST(N'2021-11-29T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (28, 1, 1687.4, CAST(N'2021-11-29T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (29, 1, 1760, CAST(N'2021-11-29T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (30, 1, 2175.8, CAST(N'2021-12-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (31, 1, 396, CAST(N'2021-12-01T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (32, 1, 739.2, CAST(N'2021-12-02T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (33, 1, 567.6, CAST(N'2021-12-03T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (34, 1, 803, CAST(N'2021-12-14T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (80, 1022, 396, CAST(N'2025-05-12T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (93, 1022, 209, CAST(N'2025-05-12T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (94, 1022, 171.6, CAST(N'2025-05-12T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (95, 1022, 223300, CAST(N'2025-05-16T00:00:00.000' AS DateTime))
INSERT [dbo].[Invoice] ([maHD], [accountID], [tongGia], [ngayXuat]) VALUES (96, 1022, 866800, CAST(N'2025-05-16T00:00:00.000' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Invoice] OFF
GO

-- Chèn dữ liệu cho bảng SoLuongDaBan
INSERT [dbo].[SoLuongDaBan] ([productID], [soLuongDaBan]) VALUES (49, 1)
INSERT [dbo].[SoLuongDaBan] ([productID], [soLuongDaBan]) VALUES (47, 1)
GO

-- Dữ liệu cho các bảng Discount, Customer, Warehouse, Review không có trong file chèn dữ liệu gốc.
-- Bảng TongChiTieuBanHang đã được loại bỏ do không có trong cấu trúc database mới.

PRINT N'Đã hoàn tất chèn dữ liệu vào database quanlybansua.'