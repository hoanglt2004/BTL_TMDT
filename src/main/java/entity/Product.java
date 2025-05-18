/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package entity;

/**
 *
 * @author 
 */
public class Product {
    private int id;
    private String name;
    private String image;
    private double price;
    private String brand; // đổi từ title sang brand theo cấu trúc db mới
    private String description;
    private int cateID; // thêm cateID
    private String image2;
    private String image3;
	public Product(int id, String name, String image, double price, String brand, String description, int cateID,
			String image2, String image3) {
		
		this.id = id;
		this.name = name;
		this.image = image;
		this.price = price;
		this.brand = brand;
		this.description = description;
		this.cateID = cateID;
		this.image2 = image2;
		this.image3 = image3;
	}
	public Product() {
		
	}
	@Override
	public String toString() {
		return "Product [id=" + id + ", name=" + name + ", image=" + image + ", price=" + price + ", brand=" + brand
				+ ", description=" + description + ", cateID=" + cateID + ", image2=" + image2 + ", image3=" + image3 + "]";
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public String getBrand() {
		return brand;
	}
	public void setBrand(String brand) {
		this.brand = brand;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public int getCateID() {
		return cateID;
	}
	public void setCateID(int cateID) {
		this.cateID = cateID;
	}
	public String getImage2() {
		return image2;
	}
	public void setImage2(String image2) {
		this.image2 = image2;
	}
	public String getImage3() {
		return image3;
	}
	public void setImage3(String image3) {
		this.image3 = image3;
	}
    
}
