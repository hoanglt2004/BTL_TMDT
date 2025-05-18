/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package control;

import dao.DAO;

import entity.Account;
import entity.Category;
import entity.Invoice;
import entity.Product;
import entity.SoLuongDaBan;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;





@WebServlet(name = "XuatExcelTop10ProductControl", urlPatterns = {"/xuatExcelTop10ProductControl"})
public class XuatExcelTop10ProductControl extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
      
        DAO dao = new DAO();
        List<Product> listAllProduct = dao.getAllProduct();
        List<SoLuongDaBan> listTop10Product = dao.getTop10SanPhamBanChay();
        
  

        int maximum=2147483647;
        int minimum=1;
        
        Random rn = new Random();
        int range = maximum - minimum + 1;
        int randomNum =  rn.nextInt(range) + minimum;

        
        // Tạo thư mục nếu chưa tồn tại
File directory = new File("C:\\Users\\ADMIN\\Documents\\ExcelWebBanSua");
if (!directory.exists()) {
    directory.mkdirs();
}

FileOutputStream file=new FileOutputStream("C:\\Users\\ADMIN\\Documents\\ExcelWebBanSua\\"+"top-10-san-pham-ban-chay-"+Integer.toString(randomNum)+".xlsx");
        XSSFWorkbook workbook=new XSSFWorkbook();
        XSSFSheet workSheet=workbook.createSheet("1");
        XSSFRow row;
        XSSFCell cell0;
        XSSFCell cell1;
        XSSFCell cell2;
        XSSFCell cell3;
        XSSFCell cell4;
        XSSFCell cell5;
        XSSFCell cell6;
        XSSFCell cell7;
        XSSFCell cell8;
        XSSFCell cell9;
        XSSFCell cell10;
        XSSFCell cell11;
        
        row=workSheet.createRow(0);
        cell0=row.createCell(0);
        cell0.setCellValue("ID");
        cell1=row.createCell(1);
        cell1.setCellValue("Name");
        cell2=row.createCell(2);
        cell2.setCellValue("Image");
        cell3=row.createCell(3);
        cell3.setCellValue("Price");
        cell4=row.createCell(4);
        cell4.setCellValue("Brand");
        cell5=row.createCell(5);
        cell5.setCellValue("Description");
        cell6=row.createCell(6);
        cell6.setCellValue("Category ID");
        cell7=row.createCell(7);
        cell7.setCellValue("Image 2");
        cell8=row.createCell(8);
        cell8.setCellValue("Image 3");
        cell9=row.createCell(9);
        cell9.setCellValue("Số lượng đã bán");
        
        int i=0;
        
        
        for (SoLuongDaBan soluong : listTop10Product) {
        	   for (Product pro : listAllProduct) {
        		   if(soluong.getProductID() == pro.getId()) {
        			   	i=i+1;
             			 row=workSheet.createRow(i);
             			 cell0=row.createCell(0);
             		     cell0.setCellValue(pro.getId());
             		     cell1=row.createCell(1);
             		     cell1.setCellValue(pro.getName());
             		     cell2=row.createCell(2);
             		     cell2.setCellValue(pro.getImage());
             		     cell3=row.createCell(3);
             		     cell3.setCellValue(pro.getPrice());	
             		     cell4=row.createCell(4);
             		     cell4.setCellValue(pro.getBrand());	
             		     cell5=row.createCell(5);
             		     cell5.setCellValue(pro.getDescription());	
             		     cell6=row.createCell(6);
             		     cell6.setCellValue(pro.getCateID());	
             		     cell7=row.createCell(7);
             		     cell7.setCellValue(pro.getImage2());	
             		     cell8=row.createCell(8);
             		     cell8.setCellValue(pro.getImage3());	
             		     cell9=row.createCell(9);
             		     cell9.setCellValue(soluong.getSoLuongDaBan());	
        		   }	
               }
        }
        
   
        workbook.write(file);
        workbook.close();
        file.close();
        
        request.setAttribute("mess", "Đã xuất file Excel thành công!");
        request.getRequestDispatcher("top10").forward(request, response); 
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
