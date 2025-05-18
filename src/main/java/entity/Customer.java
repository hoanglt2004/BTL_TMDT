package entity;

public class Customer {
    private int customer_id; // Sử dụng từ Account.uID
    private String full_name;
    private String address;
    private String province;
    
    public Customer() {
    }
    
    public Customer(int customer_id, String full_name, String address, String province) {
        this.customer_id = customer_id;
        this.full_name = full_name;
        this.address = address;
        this.province = province;
    }
    
    public int getCustomer_id() {
        return customer_id;
    }
    
    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }
    
    public String getFull_name() {
        return full_name;
    }
    
    public void setFull_name(String full_name) {
        this.full_name = full_name;
    }
    
    public String getAddress() {
        return address;
    }
    
    public void setAddress(String address) {
        this.address = address;
    }
    
    public String getProvince() {
        return province;
    }
    
    public void setProvince(String province) {
        this.province = province;
    }
    
    @Override
    public String toString() {
        return "Customer [customer_id=" + customer_id + ", full_name=" + full_name + 
               ", address=" + address + ", province=" + province + "]";
    }
}
