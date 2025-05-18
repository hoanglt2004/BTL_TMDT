<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
  
   <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <title>Material Design Bootstrap</title>
  <!-- Roboto Font -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700&display=swap">
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css">
  <!-- Bootstrap core CSS -->
  <link rel="stylesheet" href="https://mdbootstrap.com/previews/ecommerce-demo/css/bootstrap.min.css">
  <!-- Material Design Bootstrap -->
  <link rel="stylesheet" href="https://mdbootstrap.com/previews/ecommerce-demo/css/mdb-pro.min.css">
  <!-- Material Design Bootstrap Ecommerce -->
  <link rel="stylesheet" href="https://mdbootstrap.com/previews/ecommerce-demo/css/mdb.ecommerce.min.css">
  <!-- Your custom styles (optional) -->
   <link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
        <script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
        <!------ Include the above in your HEAD tag ------>
       <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet" integrity="sha384-wvfXpqpZZVQGK6TAh5PVlGOfQNHSoD2xbE+QkPxCAFlNEevoEH3Sl0sibVcOQVnN" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/> 

<style>
.sort-option {
    transition: all 0.3s ease;
    padding: 5px 10px;
    border-radius: 4px;
    cursor: pointer;
}

.sort-option:hover {
    background-color: #f8f9fa;
    transform: translateY(-2px);
}

.sort-option.active {
    background-color: #007bff;
    color: white;
    box-shadow: 0 2px 5px rgba(0,0,0,0.2);
}

.sort-option input[type="radio"] {
    display: none;
}

.sort-option label {
    cursor: pointer;
    margin: 0;
    padding: 5px 10px;
    display: inline-block;
    transition: all 0.3s ease;
}

.sort-label {
    padding: 5px 10px;
    border-radius: 4px;
    transition: background-color 0.3s ease;
}

.sort-label.active {
    background-color: #007bff;
    color: white;
}

input[type="radio"]:checked + .sort-label {
    background-color: #007bff;
    color: white;
}
</style>

</head>

<body class="skin-light" onload="loadAmountCart()">

  <!--Main Navigation-->
  <header>

 	 <jsp:include page="Menu.jsp"></jsp:include>

  </header>
  <!--Main Navigation-->

  <!--Main layout-->
  <main>
    <div class="container" style="margin-top:100px">

      <!--Grid row-->
      <div class="row mt-5">

        <!--Grid column-->
        <div class="col-md-4 mb-4">

          <!-- Section: Sidebar -->
          <section>

            <!-- Section: Categories -->
            <section>

              <h5>Categories</h5>

              <div class="text-muted small text-uppercase mb-5">
			<c:forEach items="${listCC}" var="o">
                <p class="mb-3"><a href="#" onclick="load('${o.cid}'); return false;" class="card-link-secondary">${o.cname}</a></p>
              </c:forEach>
              </div>

            </section>
            <!-- Section: Categories -->

            <!-- Section: Filters -->
            <section>

              <h5 class="pt-2 mb-4">Filters</h5>

              <section class="mb-4">

                <!-- Lấy từ khóa tìm kiếm từ request parameter -->
                <% 
                String searchKeyword = "";
                if (request.getAttribute("txtS") != null) {
                    searchKeyword = (String) request.getAttribute("txtS");
                } else if (request.getParameter("search") != null) {
                    searchKeyword = request.getParameter("search");
                }
                %>

                <!-- Hiển thị từ khóa trong ô search -->
                <div class="form-group">
                  <input type="text" class="form-control" id="searchInput" name="txt" placeholder="Enter keyword..." value="<%= searchKeyword %>" onkeyup="searchByName(this)">
                  <div id="searchSuggestions" class="dropdown-menu" style="width: 100%; max-height: 200px; overflow-y: auto;"></div>
                </div>

                <script>
                let searchTimeout;
                let currentSearchText = '';
                
                function searchByName(param) {
                    clearTimeout(searchTimeout);
                    const searchInput = document.getElementById('searchInput');
                    const suggestionsDiv = document.getElementById('searchSuggestions');
                    
                    searchTimeout = setTimeout(() => {
                        const txtSearch = searchInput.value;
                        currentSearchText = txtSearch;
                        
                        // Clear category selection when searching
                        window.currentCategoryId = null;
                        
                        if (txtSearch.length > 0) {
                            $.ajax({
                                url: "/WebsiteBanSua/searchAjaxShop",
                                type: "get",
                                data: {
                                    txt: txtSearch
                                },
                                success: function (data) {
                                    var row = document.getElementById("content");
                                    row.innerHTML = data;
                                    
                                    // Show suggestions based on search results
                                    const products = $(data).find('.product-name');
                                    if (products.length > 0) {
                                        suggestionsDiv.innerHTML = '';
                                        products.each(function() {
                                            const suggestion = document.createElement('a');
                                            suggestion.className = 'dropdown-item';
                                            suggestion.href = '#';
                                            suggestion.textContent = $(this).text();
                                            suggestion.onclick = function(e) {
                                                e.preventDefault();
                                                searchInput.value = $(this).text();
                                                searchByName({value: $(this).text()});
                                                suggestionsDiv.style.display = 'none';
                                            };
                                            suggestionsDiv.appendChild(suggestion);
                                        });
                                        suggestionsDiv.style.display = 'block';
                                    } else {
                                        suggestionsDiv.style.display = 'none';
                                    }
                                },
                                error: function (xhr) {
                                    console.error('Search failed:', xhr);
                                }
                            });
                        } else {
                            suggestionsDiv.style.display = 'none';
                            // If search is cleared, show all products
                            loadAllProducts();
                        }
                    }, 300);
                }

                function loadAllProducts() {
                    $.ajax({
                        url: "/WebsiteBanSua/loadAllProducts",
                        type: "get",
                        success: function (data) {
                            var row = document.getElementById("content");
                            row.innerHTML = data;
                        }
                    });
                }

                function load(cateid) {
                    window.currentCategoryId = cateid;
                    // Clear search input when category is selected
                    document.getElementById('searchInput').value = '';
                    currentSearchText = '';
                    
                    $.ajax({
                        url: "/WebsiteBanSua/categoryShop",
                        type: "get",
                        data: {
                            cid: cateid
                        },
                        success: function (responseData) {
                            document.getElementById("content").innerHTML = responseData;
                        }
                    });
                }
                </script>

              </section>

          
              <!-- Section: Price -->
              <section class="mb-4">

                <h6 class="font-weight-bold mb-3">Price</h6>

                <div class="form-check pl-0 mb-3">
                  <input onchange="searchByPriceAsc()" type="radio" class="form-check-input" id="priceAsc" name="materialExampleRadios">
                  <label class="form-check-label small text-uppercase card-link-secondary" for="priceAsc">Price: Low to High</label>
                </div>
                <div class="form-check pl-0 mb-3">
                  <input onchange="searchByPriceDesc()" type="radio" class="form-check-input" id="priceDesc" name="materialExampleRadios">
                  <label class="form-check-label small text-uppercase card-link-secondary" for="priceDesc">Price: High to Low</label>
                </div>
                <form>
                  <div class="d-flex align-items-center mt-4 pb-1">
                    <div class="md-form md-outline my-0">
                      <input oninput="searchByPriceMinToMax()" id="priceMin" type="text" class="form-control mb-0">
                      <label for="priceMin">$ Min</label>
                    </div>
                    <p class="px-2 mb-0 text-muted"> - </p>
                    <div class="md-form md-outline my-0">
                      <input oninput="searchByPriceMinToMax()" id="priceMax" type="text" class="form-control mb-0">
                      <label for="priceMax">$ Max</label>
                    </div>
                  </div>
                </form>

              </section>
              <!-- Section: Price -->

            </section>
            <!-- Section: Filters -->

          </section>
          <!-- Section: Sidebar -->

        </div>
        <!--Grid column-->

        <!--Grid column-->
        <div class="col-md-8 mb-4">

          <!-- Section: Block Content -->
          <section class="mb-3">

            <div class="row d-flex justify-content-around align-items-center">
              <div class="col-12 col-md-8 text-center text-md-left">
                <form id="sortForm" class="d-flex align-items-center">
                  <label class="mr-2 font-weight-bold">Xếp theo:</label>
                  <input type="radio" id="sortDefault" name="sortOption" value="default" checked class="ml-2 mr-1" onclick="sortProducts('default')">
                  <label for="sortDefault" class="mr-3 sort-label">Mặc định</label>
                  <input type="radio" id="sortAZ" name="sortOption" value="az" class="mr-1" onclick="sortProducts('az')">
                  <label for="sortAZ" class="mr-3 sort-label">Tên A-Z</label>
                  <input type="radio" id="sortZA" name="sortOption" value="za" class="mr-1" onclick="sortProducts('za')">
                  <label for="sortZA" class="mr-3 sort-label">Tên Z-A</label>
                  <input type="radio" id="sortNew" name="sortOption" value="new" class="mr-1" onclick="sortProducts('new')">
                  <label for="sortNew" class="sort-label">Hàng mới</label>
                </form>
              </div>
            </div>
            <script>
            function sortProducts(type) {
                var searchText = document.getElementById('searchInput').value;
                var cid = window.currentCategoryId;
                let url = '';
                let data = { txt: searchText, cid: cid };
                if(type === 'default') {
                    loadAllProducts();
                    return;
                } else if(type === 'az') {
                    url = '/WebsiteBanSua/sortByNameAZ';
                } else if(type === 'za') {
                    url = '/WebsiteBanSua/sortByNameZA';
                } else if(type === 'new') {
                    url = '/WebsiteBanSua/sortByNewest';
                }
                $.ajax({
                    url: url,
                    type: 'get',
                    data: data,
                    success: function(data) {
                        var row = document.getElementById('content');
                        row.innerHTML = data;
                    }
                });
            }
            </script>

          </section>
          <!-- Section: Block Content -->

          <!--Section: Block Content-->
          <section>

            <!-- Grid row -->
            <div class="row" id="content">


<c:forEach items="${listP}" var="o">
              <!-- Grid column -->
              <div class="col-md-4 mb-5">

                <!-- Card -->
                <div class="">

                  <div class="view zoom overlay rounded z-depth-2">
                    <img class="img-fluid w-100"
                      src="${o.image }" alt="Sample">
                    <a href="detail?pid=${o.id}">
                      <div class="mask">
                        <img class="img-fluid w-100"
                          src="${o.image }">
                        <div class="mask rgba-black-slight"></div>
                      </div>
                    </a>
                  </div>

                  <div class="text-center pt-4">

                    <h5>${o.name }</h5>
                    <p><span class="mr-1"><strong>${o.price }$</strong></span></p>

                  </div>

                </div>
                <!-- Card -->

              </div>
              <!-- Grid column -->
   </c:forEach>     
              
            </div>
            <!-- Grid row -->
          </section>
          <!--Section: Block Content-->

    </div>
  </main>
  <!--Main layout-->

  <!-- Footer -->
  

   <jsp:include page="Footer.jsp"></jsp:include>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <!-- Footer -->



  <!-- SCRIPTS -->
  <!-- JQuery -->
  <script src="https://mdbootstrap.com/previews/ecommerce-demo/js/jquery-3.4.1.min.js"></script>
  <!-- Bootstrap tooltips -->
  <script type="text/javascript" src="https://mdbootstrap.com/previews/ecommerce-demo/js/popper.min.js"></script>
  <!-- Bootstrap core JavaScript -->
  <script type="text/javascript" src="https://mdbootstrap.com/previews/ecommerce-demo/js/bootstrap.js"></script>
  <!-- MDB core JavaScript -->
  <script type="text/javascript" src="https://mdbootstrap.com/previews/ecommerce-demo/js/mdb.min.js"></script>
    <!-- MDB Ecommerce JavaScript -->
    <script type="text/javascript" src="https://mdbootstrap.com/previews/ecommerce-demo/js/mdb.ecommerce.min.js"></script>
  <script>
    // Gán biến toàn cục để lưu mã danh mục hiện tại
    window.currentCategoryId = null;

    $('#multi').mdbRange({
      single: {
        active: true,
        multi: {
          active: true,
          rangeLength: 1
        },
      }
    });

    $(document).ready(function () {
      $('.mdb-select').materialSelect();
      $('.select-wrapper.md-form.md-outline input.select-dropdown').bind('focus blur', function () {
        $(this).closest('.select-outline').find('label').toggleClass('active');
        $(this).closest('.select-outline').find('.caret').toggleClass('active');
      });
    });
    function load(cateid){
        window.currentCategoryId = cateid;
        $.ajax({
            url: "/WebsiteBanSua/categoryShop",
            type: "get",
            data: {
                cid: cateid
            },
            success: function (responseData) {
                document.getElementById("content").innerHTML = responseData;
            }
        });
    }  
    function searchByPriceMinToMax(){
        var numMin = document.getElementById("priceMin").value;
        var numMax = document.getElementById("priceMax").value;
        $.ajax({
            url: "/WebsiteBanSua/searchAjaxPriceMinToMax",
            type: "get", //send it through get method
            data: {
                priceMin: numMin,
                priceMax: numMax
            },
            success: function (data) {
                var row = document.getElementById("content");
                row.innerHTML = data;
            },
            error: function (xhr) {
                //Do Something to handle error
            }
        });
    }
    function searchByPriceAsc(){
        var searchText = document.getElementById('searchInput').value;
        var cid = window.currentCategoryId;
        $.ajax({
            url: "/WebsiteBanSua/searchAjaxPriceAsc",
            type: "get",
            data: {
                txt: searchText,
                cid: cid
            },
            success: function (data) {
                var row = document.getElementById("content");
                row.innerHTML = data;
            }
        });
    }
    function searchByPriceDesc(){
        var searchText = document.getElementById('searchInput').value;
        var cid = window.currentCategoryId;
        $.ajax({
            url: "/WebsiteBanSua/searchAjaxPriceDesc",
            type: "get",
            data: {
                txt: searchText,
                cid: cid
            },
            success: function (data) {
                var row = document.getElementById("content");
                row.innerHTML = data;
            }
        });
    }
    function loadAmountCart(){
    	 $.ajax({
             url: "/WebsiteBanSua/loadAllAmountCart",
             type: "get", //send it through get method
             data: {
                 
             },
             success: function (responseData) {
                 document.getElementById("amountCart").innerHTML = responseData;
             }
         });
    }         
  </script>
  	 <!-- MDB -->
    <script type="text/javascript" src="js/mdb.min.js"></script>
    <!-- Custom scripts -->
    <script type="text/javascript" src="js/script.js"></script>
</body>

</html>