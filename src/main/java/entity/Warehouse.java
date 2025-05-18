package entity;

import java.util.Date;

public class Warehouse {
    private int product_id;
    private int stock_quantity;
    private String location;
    private Date last_updated_date;
    
    public Warehouse() {
    }
    
    public Warehouse(int product_id, int stock_quantity, String location, Date last_updated_date) {
        this.product_id = product_id;
        this.stock_quantity = stock_quantity;
        this.location = location;
        this.last_updated_date = last_updated_date;
    }
    
    public int getProduct_id() {
        return product_id;
    }
    
    public void setProduct_id(int product_id) {
        this.product_id = product_id;
    }
    
    public int getStock_quantity() {
        return stock_quantity;
    }
    
    public void setStock_quantity(int stock_quantity) {
        this.stock_quantity = stock_quantity;
    }
    
    public String getLocation() {
        return location;
    }
    
    public void setLocation(String location) {
        this.location = location;
    }
    
    public Date getLast_updated_date() {
        return last_updated_date;
    }
    
    public void setLast_updated_date(Date last_updated_date) {
        this.last_updated_date = last_updated_date;
    }
    
    @Override
    public String toString() {
        return "Warehouse [product_id=" + product_id + ", stock_quantity=" + stock_quantity + 
               ", location=" + location + ", last_updated_date=" + last_updated_date + "]";
    }
}
