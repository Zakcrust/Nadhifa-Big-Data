<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="BigDataASP.UploadData.WebForm1" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="ajaxToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

    protected void UploadButton_Click(object sender, EventArgs e)
    {
        // Save the uploaded file to an "Uploads" directory
        // that already exists in the file system of the 
        // currently executing ASP.NET application.  
        // Creating an "Uploads" directory isolates uploaded 
        // files in a separate directory. This helps prevent
        // users from overwriting existing application files by
        // uploading files with names like "Web.config".
        string saveDir = @"\Uploads\";

        // Get the physical file system path for the currently
        // executing application.
        string appPath = Request.PhysicalApplicationPath;

        // Before attempting to save the file, verify
        // that the FileUpload control contains a file.
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

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>FileUpload Class Example</title>
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
</head>
<body>

    <h3>FileUpload Class Example: Save To Application Directory</h3>
    <form id="form1" runat="server">

        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>


        <div>
            <h4>Select a file to upload:</h4>

            <asp:FileUpload ID="FileUpload1"
                runat="server"></asp:FileUpload>

            <br />
            <br />

            <asp:Button ID="UploadButton"
                Text="Upload file"
                OnClick="UploadButton_Click"
                runat="server"></asp:Button>

            <hr />

            <asp:Label ID="UploadStatusLabel"
                runat="server">
            </asp:Label>
            <asp:Label ID="exceltosqlException" runat="server">
            </asp:Label>

        </div>


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
        <div class="container">
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



    </form>

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



            var patientDataChart = document.getElementById('myChart').getContext('2d');
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


            var topProductDataChart = document.getElementById('topProductChart').getContext('2d');
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

            var topCityDataChart = document.getElementById('topCityChart').getContext('2d');
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

            var topProvinceDataChart = document.getElementById('topProvinceChart').getContext('2d');
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


</body>
</html>
