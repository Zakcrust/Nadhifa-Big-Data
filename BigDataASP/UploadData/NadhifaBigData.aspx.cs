using Nadhifa_Library.CRUD.QueryBuilderClass;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BigDataASP.UploadData
{
    public partial class NadhifaBigData : System.Web.UI.Page
    {

        public Dictionary<string, string> firstData = new Dictionary<string, string>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindData();
                BindCharts();
            }
        }


        QueryBuilder queryBuilder = new QueryBuilder("Data Source=localhost;Initial Catalog=nadhifa_ts;Integrated Security=True");

        public void ImportDataFromExcel(string excelFilePath)
        {
            //declare variables - edit these based on your particular situation   
            string ssqltable = "raw_data";
            string excelDataQuery = "Select * from [Sheet1$]";

            try
            {
                string sexcelconnectionstring = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + excelFilePath + ";Extended Properties='Excel 12.0;'";
                string ssqlconnectionstring = "Data Source=localhost;Initial Catalog=nadhifa_ts;Integrated Security=True";
                //execute a query to erase any previous data from our destination table   
                string sclearsql = "delete from " + ssqltable;
                SqlConnection sqlconn = new SqlConnection(ssqlconnectionstring);
                SqlCommand sqlcmd = new SqlCommand(sclearsql, sqlconn);
                sqlconn.Open();
                sqlcmd.ExecuteNonQuery();
                sqlconn.Close();
                //series of commands to bulk copy data from the excel file into our sql table   
                OleDbConnection oledbconn = new OleDbConnection(sexcelconnectionstring);
                OleDbCommand oledbcmd = new OleDbCommand(excelDataQuery, oledbconn);
                oledbconn.Open();
                OleDbDataReader dr = oledbcmd.ExecuteReader();
                SqlBulkCopy bulkcopy = new SqlBulkCopy(ssqlconnectionstring);
                bulkcopy.DestinationTableName = ssqltable;
                while (dr.Read())
                {
                    bulkcopy.WriteToServer(dr);
                }
                dr.Close();
                oledbconn.Close();

                sqlconn = new SqlConnection(ssqlconnectionstring);
                sqlcmd = new SqlCommand("Sp_SanitizeData", sqlconn);
                sqlcmd.CommandType = System.Data.CommandType.StoredProcedure;
                sqlconn.Open();
                sqlcmd.ExecuteNonQuery();
                sqlconn.Close();
                UploadStatusLabel.Text = "File imported into sql server successfully.";
            }
            catch (Exception ex)
            {
                exceltosqlException.Text = ex.ToString();
            }
        }


        public void BindData()
        {

            DataTable dt = new DataTable();
            dt = queryBuilder.customSelectQuery("Select * from GetAllData");
            RptDataTransaksi.DataSource = dt;
            RptDataTransaksi.DataBind();
        }


        public void BindCharts()
        {
            DataTable topPatient = new DataTable();
            topPatient = queryBuilder.customSelectQuery("SELECT * FROM [TOP SPENDING]");

            DataTable topSellingProduct = new DataTable();
            topSellingProduct = queryBuilder.customSelectQuery("SELECT * FROM [TOP Selling Product]");

            DataTable topCities = new DataTable();
            topCities = queryBuilder.customSelectQuery("SELECT * FROM [Top Cities]");

            DataTable topProvinces = new DataTable();
            topProvinces = queryBuilder.customSelectQuery("SELECT * FROM [Top Provinces]");

            firstData.Add("customer_name", topPatient.Rows[0]["customer_name"].ToString());
            firstData.Add("spending_power", topPatient.Rows[0]["spending_power"].ToString());

            firstData.Add("top_product", topSellingProduct.Rows[0]["top_product"].ToString());
            firstData.Add("product_amount", topSellingProduct.Rows[0]["product_amount"].ToString());

            firstData.Add("city", topCities.Rows[0]["city"].ToString());
            firstData.Add("city_order_amount", topCities.Rows[0]["order_amount"].ToString());

            firstData.Add("province", topProvinces.Rows[0]["province"].ToString());
            firstData.Add("province_order_amount", topProvinces.Rows[0]["order_amount"].ToString());


            //DataRow firstData = topPatient.Rows[0];

            List<string> customer_name = new List<string>();
            List<string> spending_power = new List<string>();

            List<string> topProduct = new List<string>();
            List<string> productAmount = new List<string>();

            List<string> topCity = new List<string>();
            List<string> productcityAmount = new List<string>();

            List<string> topProvince = new List<string>();
            List<string> productprovinceAmount = new List<string>();


            foreach (DataRow row in topPatient.Rows)
            {
                customer_name.Add(row["customer_name"].ToString());
                spending_power.Add(row["spending_power"].ToString());
            }

            foreach (DataRow row in topSellingProduct.Rows)
            {
                topProduct.Add(row["top_product"].ToString());
                productAmount.Add(row["product_amount"].ToString());
            }

            foreach (DataRow row in topCities.Rows)
            {
                topCity.Add(row["city"].ToString());
                productcityAmount.Add(row["order_amount"].ToString());

            }

            foreach (DataRow row in topProvinces.Rows)
            {
                topProvince.Add(row["province"].ToString());
                productprovinceAmount.Add(row["order_amount"].ToString());

            }


            this.customer_name.Value = JsonConvert.SerializeObject(customer_name);
            this.spending_power.Value = JsonConvert.SerializeObject(spending_power);

            topProductData.Value = JsonConvert.SerializeObject(topProduct);
            productAmountData.Value = JsonConvert.SerializeObject(productAmount);

            topCityData.Value = JsonConvert.SerializeObject(topCity);
            productcityData.Value = JsonConvert.SerializeObject(productcityAmount);

            topProvinceData.Value = JsonConvert.SerializeObject(topProvince);
            productProvinceData.Value = JsonConvert.SerializeObject(productprovinceAmount);


            //foreach(DataRow row in topPatient.Rows)
            //{
            //    decimal val = decimal.Parse(row["spending_power"].ToString());
            //    PatientChart.Series.Add(new AjaxControlToolkit.BarChartSeries { Name = row["customer_name"].ToString(), Data = new decimal[] { val } });
            //}

            //BarChart1.Series.Add(new AjaxControlToolkit.BarChartSeries { Name = ddlCountry2.SelectedItem.Value, Data = y });
        }

        protected void OnFilterDataClick(object sender, EventArgs e)
        {
            if (from_date.Text == "" || to_date.Text == "")
            {
                filterDataFailed.Visible = true;
                return;
            }

            filterDataFailed.Visible = false;
            using (SqlConnection con = new SqlConnection("Data Source=localhost;Initial Catalog=nadhifa_ts;Integrated Security=True"))
            {
                using (SqlCommand cmd = new SqlCommand("GetFilterDateData"))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@from", SqlDbType.Date).Value = from_date.Text;
                    cmd.Parameters.Add("@to", SqlDbType.Date).Value = to_date.Text;

                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            RptDataTransaksi.DataSource = dt;
                            RptDataTransaksi.DataBind();
                            this.BindCharts();
                        }
                    }

                }
            }

        }
    }
}