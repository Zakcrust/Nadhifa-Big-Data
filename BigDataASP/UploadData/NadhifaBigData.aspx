<%@ Title="Nadhifa Big Data" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="NadhifaBigData.aspx.cs" Inherits="BigDataASP.UploadData.NadhifaBigData" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<script runat="server">

    protected void UploadButton_Click(object sender, EventArgs e)
    {
        
        string saveDir = @"\Uploads\";
        string appPath = Request.PhysicalApplicationPath;

        if (FileUpload1.HasFile)
        {
            string savePath = appPath + saveDir +
                Server.HtmlEncode(FileUpload1.FileName);

            // Call the SaveAs method to save the 
            // uploaded file to the specified path.
            // This example does not perform all
            // the necessary error checking.               
            // If a file with the same name
            // already exists in the specified path,  
            // the uploaded file overwrites it.
            FileUpload1.SaveAs(savePath);
            ImportDataFromExcel(savePath);
            // Notify the user that the file was uploaded successfully.
            UploadStatusLabel.Text = "Your file was uploaded successfully.";

        }
        else
        {
            // Notify the user that a file was not uploaded.
            UploadStatusLabel.Text = "You did not specify a file to upload.";
        }
    }
</script>


<asp:Content runat ="server" ContentPlaceHolderID="MainContent">
    <link rel="stylesheet" href="../Content/bootstrap.css" />
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css">
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
    <script type="text/javascript" src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js">
    </script>
    <script type="text/javascript" src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js" defer="defer"></script>
    <style type="text/css">
        .separator {
            margin-top : 100px;
            margin-bottom : 100px;
        }
    </style>


    <script type="text/javascript">
        $(document).ready(function () {
            $('#myTable').DataTable();

            Chart.defaults.global.legend.display = false;
            var decoded_customer_name = JSON.parse(document.getElementById('<%= customer_name.ClientID%>').value);
            var decoded_spending_power = JSON.parse(document.getElementById('<%= spending_power.ClientID%>').value);
            var decoded_topProductData = JSON.parse(document.getElementById('<%= topProductData.ClientID%>').value);
            var decoded_productAmountData = JSON.parse(document.getElementById('<%= productAmountData.ClientID%>').value);
            var decoded_topCityData = JSON.parse(document.getElementById('<%= topCityData.ClientID%>').value);
            var decoded_productCityData = JSON.parse(document.getElementById('<%= productcityData.ClientID%>').value);
            var decoded_topProvinceData = JSON.parse(document.getElementById('<%= topProvinceData.ClientID%>').value);
            var decoded_productProvinceData = JSON.parse(document.getElementById('<%= productProvinceData.ClientID%>').value);



            var patientDataChart = document.getElementById('MainContent_myChart').getContext('2d');
            var LoyalPatientchart = new Chart(patientDataChart, {
                // The type of chart we want to create
                type: 'bar',

                // The data for our dataset
                data: {
                    labels: decoded_customer_name,
                    datasets: [{
                        //label: 'Pasien Terloyal',
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 3,
                        data: decoded_spending_power
                    }]
                },

                // Configuration options go here
                options: {}
            });


            var topProductDataChart = document.getElementById('MainContent_topProductChart').getContext('2d');
            var TopProductchart = new Chart(topProductDataChart, {
                // The type of chart we want to create
                type: 'bar',

                // The data for our dataset
                data: {
                    labels: decoded_topProductData,
                    datasets: [{
                        //label: 'Top Seller Product',
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 3,
                        data: decoded_productAmountData
                    }]
                },

                // Configuration options go here
                options: {}
            });

            var topCityDataChart = document.getElementById('MainContent_topCityChart').getContext('2d');
            var CityProductchart = new Chart(topCityDataChart, {
                // The type of chart we want to create
                type: 'bar',

                // The data for our dataset
                data: {
                    labels: decoded_topCityData,
                    datasets: [{
                        //label: 'Top Cities',
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 3,
                        data: decoded_productCityData
                    }]
                },

                // Configuration options go here
                options: {}
            });

            var topProvinceDataChart = document.getElementById('MainContent_topProvinceChart').getContext('2d');
            var TopProductchart = new Chart(topProvinceDataChart, {
                // The type of chart we want to create
                type: 'bar',

                // The data for our dataset
                data: {
                    labels: decoded_topProvinceData,
                    datasets: [{
                        //label: 'Top Province',
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255, 99, 132, 1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 3,
                        data: decoded_productProvinceData
                    }]
                },

                // Configuration options go here
                options: {
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero: true
                            }
                        }]
                    }
                }
            });

            var patientData = {
                labels: decoded_customer_name,
                datasets: [{
                    //label: 'Pasien Terloyal',
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 3,
                    data: decoded_spending_power
                }]
            }

            var productData = {
                labels: decoded_topProductData,
                datasets: [{
                    //label: 'Top Seller Product',
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 3,
                    data: decoded_productAmountData
                }]
            }

            var cityData = {
                labels: decoded_topCityData,
                datasets: [{
                    //label: 'Top Cities',
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 3,
                    data: decoded_productCityData
                }]
            }

            var provinceData = {
                labels: decoded_topProvinceData,
                datasets: [{
                    //label: 'Top Province',
                    backgroundColor: [
                        'rgba(255, 99, 132, 0.2)',
                        'rgba(54, 162, 235, 0.2)',
                        'rgba(255, 206, 86, 0.2)',
                        'rgba(75, 192, 192, 0.2)',
                        'rgba(153, 102, 255, 0.2)',
                        'rgba(255, 159, 64, 0.2)'
                    ],
                    borderColor: [
                        'rgba(255, 99, 132, 1)',
                        'rgba(54, 162, 235, 1)',
                        'rgba(255, 206, 86, 1)',
                        'rgba(75, 192, 192, 1)',
                        'rgba(153, 102, 255, 1)',
                        'rgba(255, 159, 64, 1)'
                    ],
                    borderWidth: 3,
                    data: decoded_productProvinceData
                }]
            }


        });

        $("#home").click(function () {
            LoyalPatientchart = new Chart(patientDataChart, patientData);
        });
    </script>

    <script src="https://threejs.org/build/three.js"></script>
    <script src="../Scripts/vanta.net.min.js"></script>
    <script defer type="text/javascript">
        //VANTA.NET({
        //    el: "body",
        //    mouseControls: false,
        //    touchControls: false,
        //    gyroControls: false,
        //    minHeight: 200.00,
        //    minWidth: 200.00,
        //    scale: 0.30,
        //    scaleMobile: 0.30
        //    })
    </script>

        <div class="container">
            <h1 ><span class="label label-info">Upload file excel (xls, xlsx)</span></h1>
            <br />
            <br />
            <asp:FileUpload  ID="FileUpload1"
                runat="server"></asp:FileUpload>

                <asp:Button ID="UploadButton"
                Text="Upload file"
                OnClick="UploadButton_Click"
                CssClass="btn btn-primary btn-lg btn-block"
                runat="server"></asp:Button>
            <br />
            <br />
            <asp:Label ID="UploadStatusLabel"
                runat="server">
            </asp:Label>
            <asp:Label ID="exceltosqlException" runat="server">
            </asp:Label>

        </div>

    <div class="separator"></div>


    <div class="container text-success">
            <ul class="nav nav-tabs">
                <li class="active"><a data-toggle="tab" href="#home">Pasien Terloyal</a></li>
                <li><a data-toggle="tab" href="#menu2">Produk Best Seller</a></li>
                <li><a data-toggle="tab" href="#menu3">Kota/Kabupaten Terbanyak</a></li>
                <li><a data-toggle="tab" href="#menu4">Provinsi Terbanyak</a></li>
            </ul>

            <div class="tab-content">
                <div id="home" class="tab-pane fade in active text-center">
                    <h3>Pasien Terloyal</h3>
                    <h1><span id="topPatient" class="label label-success text-center !important" ><span class="glyphicon glyphicon-star" />     <%= firstData["customer_name"] %>     <span class="glyphicon glyphicon-star" /></span>
                    </h1>
                    <br />

                    <asp:HiddenField ID="customer_name" runat="server"></asp:HiddenField>
                    <asp:HiddenField ID="spending_power" runat="server"></asp:HiddenField>

                    <canvas runat="server" id="myChart">

                        </canvas>
                </div>
                <div id="menu2" class="tab-pane fade text-center">
                    <h3>Produk Best Seller</h3>
                    <h1><span id="topProduct" class="label label-success text-center"><span class="glyphicon glyphicon-star" />     <%= firstData["top_product"] %>     <span class="glyphicon glyphicon-star" /></span>
                    </h1>
                    <br />
                    <asp:HiddenField ID="topProductData" runat="server"></asp:HiddenField>
                    <asp:HiddenField ID="productAmountData" runat="server"></asp:HiddenField>
                    <canvas runat="server" id="topProductChart">

                        </canvas>
                </div>
                <div id="menu3" class="tab-pane fade text-center">
                    <h3>Kota/Kabupaten Terbanyak</h3>
                    <h1><span id="topCity" class="label label-success text-center"><span class="glyphicon glyphicon-star" />     <%= firstData["city"] %>     <span class="glyphicon glyphicon-star" /></span>
                    </h1>
                    <br />
                    <asp:HiddenField ID="topCityData" runat="server"></asp:HiddenField>
                    <asp:HiddenField ID="productcityData" runat="server"></asp:HiddenField>
                    <canvas runat="server" id="topCityChart">

                        </canvas>
                </div>
                <div id="menu4" class="tab-pane fade text-center">
                    <h3>Provinsi Terbanyak</h3>
                    <h1><span id="topProvince" class="label label-success text-center"><span class="glyphicon glyphicon-star" />     <%= firstData["province"] %>     <span class="glyphicon glyphicon-star" /></span>
                    </h1>
                    <br />
                    <asp:HiddenField ID="topProvinceData" runat="server"></asp:HiddenField>
                    <asp:HiddenField ID="productProvinceData" runat="server"></asp:HiddenField>
                    <canvas runat="server" id="topProvinceChart">

                        </canvas>
                </div>
            </div>
        </div>

        
        <div class="separator"></div>

        

        <div class="container-fluid">
            <div class="form-inline">
                <div class="form-group">
                    <asp:Label runat="server" Text="From :" />
                    <asp:TextBox CssClass="form-control" runat="server" ID="from_date" TextMode="Date"></asp:TextBox><br />
                </div>
                <div class="form-group">
                    <asp:Label runat="server" Text="To :" />
                    <asp:TextBox CssClass="form-control" runat="server" ID="to_date" TextMode="Date"></asp:TextBox><br />
                </div>

                <asp:Button runat="server" CssClass="btn btn-primary" Text="Filter" OnClick="OnFilterDataClick" /><br />
            </div>

            <h3><asp:Label runat="server" ID="filterDataFailed" CssClass="alert alert-danger" Text="Date must not empty." Visible="false" ></asp:Label></h3>
            <br />

            <asp:Repeater runat="server" ID="RptDataTransaksi">
                <HeaderTemplate>
                    <table id="myTable" class="table table-striped table-bordered" style="width: 100%">
                        <thead>
                            <tr>
                                <th>Nomor order</th>
                                <th>Status Pesanan</th>
                                <th>Status Pembatalan/ Pengembalian</th>
                                <th>No. Resi</th>
                                <th>Opsi Pengiriman</th>
                                <th>Antar Ke Counter/ Pick-up</th>
                                <th>Pesanan Harus Dikirim Sebelum</th>
                                <th>Waktu Pengiriman Diatur</th>
                                <th>Waktu Pesanan Dibuat</th>
                                <th>Waktu Pembayaran Dilakukan</th>
                                <th>SKU Induk</th>
                                <th>Nama Produk</th>
                                <th>Nomor Referensi SKU</th>
                                <th>Nama Variasi</th>
                                <th>Harga Awal</th>
                                <th>Harga Setelah Diskom</th>
                                <th>Jumlah</th>
                                <th>Total Harga Produk</th>
                                <th>Total Diskon</th>
                                <th>Diskon Dari Penjual</th>
                                <th>Diskon Dari Shopee</th>
                                <th>Berat Produk</th>
                                <th>Jumlah Produk Dipesan</th>
                                <th>Total Berat</th>
                                <th>Voucher Ditanggung Penjual</th>
                                <th>Cashback Koin</th>
                                <th>Voucher Ditanggung Shopee</th>
                                <th>Paket Diskon</th>
                                <th>Paket Diskon (Diskon dari Shopee)</th>
                                <th>Paket Diskon (Diskon dari Penjual)</th>
                                <th>Potongan Koin Shopee</th>
                                <th>Diskon Kartu Kredit</th>
                                <th>Ongkos Kirim Dibayar Oleh Pembeli</th>
                                <th>Total Pembayaran</th>
                                <th>Perkiraan Ongkos Kirim</th>
                                <th>Catatan dari Pembeli</th>
                                <th>Catatan</th>
                                <th>Username (Pembeli)</th>
                                <th>Nama Pembeli</th>
                                <th>No. Telepon</th>
                                <th>Alamat Pengiriman</th>
                                <th>Kota/ Kabupaten</th>
                                <th>Provinsi</th>
                                <th>Waktu Pesanan Selesai</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("no_order") %></td>
                        <td><%# Eval("order_status") %></td>
                        <td><%# Eval("return_status") %></td>
                        <td><%# Eval("receipt") %></td>
                        <td><%# Eval("delivery_options") %></td>
                        <td><%# Eval("counter_or_pickup") %></td>
                        <td><%# Eval("deliver_before") %></td>
                        <td><%# Eval("arranged_delivery_time") %></td>
                        <td><%# Eval("order_create_time") %></td>
                        <td><%# Eval("payment_paid_time") %></td>
                        <td><%# Eval("sku") %></td>
                        <td><%# Eval("product_name") %></td>
                        <td><%# Eval("sku_reference") %></td>
                        <td><%# Eval("variation_name") %></td>
                        <td><%# Eval("init_price") %></td>
                        <td><%# Eval("discount_price") %></td>
                        <td><%# Eval("amount") %></td>
                        <td><%# Eval("total_price") %></td>
                        <td><%# Eval("total_discount") %></td>
                        <td><%# Eval("seller_discount") %></td>
                        <td><%# Eval("shopee_discount") %></td>
                        <td><%# Eval("product_weight") %></td>
                        <td><%# Eval("ordered_product") %></td>
                        <td><%# Eval("total_weight") %></td>
                        <td><%# Eval("seller_voucher") %></td>
                        <td><%# Eval("cashback_coin") %></td>
                        <td><%# Eval("shopee_voucher") %></td>
                        <td><%# Eval("discount_packet") %></td>
                        <td><%# Eval("shopee_discount_packet") %></td>
                        <td><%# Eval("seller_discount_packet") %></td>
                        <td><%# Eval("shopee_coin_discount_packet") %></td>
                        <td><%# Eval("credit_card_discount") %></td>
                        <td><%# Eval("postal_fee") %></td>
                        <td><%# Eval("total_payment") %></td>
                        <td><%# Eval("estimated_postal_fee") %></td>
                        <td><%# Eval("customer_note") %></td>
                        <td><%# Eval("note") %></td>
                        <td><%# Eval("customer_id") %></td>
                        <td><%# Eval("customer_name") %></td>
                        <td><%# Eval("customer_phone_number") %></td>
                        <td><%# Eval("customer_address") %></td>
                        <td><%# Eval("customer_city") %></td>
                        <td><%# Eval("customer_province") %></td>
                        <td><%# Eval("order_finished_time") %></td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </tbody>
                        </table>
                </FooterTemplate>
            </asp:Repeater>
        </div>

        <script type="text/javascript">
        </script>


</asp:Content>


        <%--<div class="col-md-6">
            <div class="panel panel-primary">
                <div class="panel-heading text-center">
                    <h3 class="panel-title text-center">Pasien Terloyal</h3>
                </div>
                <div class="panel-body text-center">
                </div>
            </div>
        </div>

        <div class="col-md-6">
            <div class="panel panel-primary">
                <div class="panel-heading text-center">
                    <h3 class="panel-title">Produk Terlaris</h3>
                </div>
                <div class="panel-body text-center">

                    <h1><span id="topProduct" class="label label-success"><span class="glyphicon glyphicon-star" /><%= firstData["top_product"] %>     <span class="glyphicon glyphicon-star" /></span>
                    </h1>
                    <br />
                    <asp:HiddenField ID="topProductData" runat="server"></asp:HiddenField>
                    <asp:HiddenField ID="productAmountData" runat="server"></asp:HiddenField>
                    <canvas runat="server" id="topProductChart">

                        </canvas>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="panel panel-primary">
                <div class="panel-heading text-center">
                    <h3 class="panel-title">Kota Terbanyak</h3>
                </div>
                <div class="panel-body text-center">

                    <h1><span id="topCity" class="label label-success"><span class="glyphicon glyphicon-star" /><%= firstData["city"] %>     <span class="glyphicon glyphicon-star" /></span>
                    </h1>
                    <br />
                    <asp:HiddenField ID="topCityData" runat="server"></asp:HiddenField>
                    <asp:HiddenField ID="productcityData" runat="server"></asp:HiddenField>
                    <canvas runat="server" id="topCityChart">

                        </canvas>
                </div>
            </div>
        </div>
        <div class="col-md-6">
            <div class="panel panel-primary">
                <div class="panel-heading text-center">
                    <h3 class="panel-title">Provinsi Terbanyak</h3>
                </div>
                <div class="panel-body text-center">

                    <h1><span id="topProvince" class="label label-success"><span class="glyphicon glyphicon-star" /><%= firstData["province"] %>     <span class="glyphicon glyphicon-star" /></span>
                    </h1>
                    <br />
                    <asp:HiddenField ID="topProvinceData" runat="server"></asp:HiddenField>
                    <asp:HiddenField ID="productProvinceData" runat="server"></asp:HiddenField>
                    <canvas runat="server" id="topProvinceChart">

                        </canvas>
                </div>
            </div>
        </div>--%>
       
