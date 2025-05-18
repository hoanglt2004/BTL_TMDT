package entity;

import java.util.Date;
import java.math.BigDecimal;

public class Discount {
    private int discount_id;
    private BigDecimal discount_value;
    private Date start_date;
    private Date end_date;
    private int id_product;
    
    public Discount() {
    }
    
    public Discount(int discount_id, BigDecimal discount_value, Date start_date, Date end_date, int id_product) {
        this.discount_id = discount_id;
        this.discount_value = discount_value;
        this.start_date = start_date;
        this.end_date = end_date;
        this.id_product = id_product;
    }
    
    public int getDiscount_id() {
        return discount_id;
    }
    
    public void setDiscount_id(int discount_id) {
        this.discount_id = discount_id;
    }
    
    public BigDecimal getDiscount_value() {
        return discount_value;
    }
    
    public void setDiscount_value(BigDecimal discount_value) {
        this.discount_value = discount_value;
    }
    
    public Date getStart_date() {
        return start_date;
    }
    
    public void setStart_date(Date start_date) {
        this.start_date = start_date;
    }
    
    public Date getEnd_date() {
        return end_date;
    }
    
    public void setEnd_date(Date end_date) {
        this.end_date = end_date;
    }
    
    public int getId_product() {
        return id_product;
    }
    
    public void setId_product(int id_product) {
        this.id_product = id_product;
    }
    
    @Override
    public String toString() {
        return "Discount [discount_id=" + discount_id + ", discount_value=" + discount_value + 
               ", start_date=" + start_date + ", end_date=" + end_date + 
               ", id_product=" + id_product + "]";
    }
}
