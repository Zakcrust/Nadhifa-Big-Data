using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace Nadhifa_Library.CRUD.QueryBuilderClass
{
    public class QueryBuilder
    {
        private SqlConnection sqlConnection;
        private SqlCommand command;
        private string connection_string;
        private string insert_query;
        private string update_query;
        private string delete_query;

        public QueryBuilder(string connection_query)
        {
            connection_string = connection_query;
            sqlConnection = new SqlConnection(connection_query);
        }

        public DataTable selectForGridView(string table_name)
        {
            using (SqlConnection con = sqlConnection)
            {
                using (SqlCommand cmd = new SqlCommand(@"SELECT * FROM " + table_name))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
        }

        public DataTable customSelectQuery(string query)
        {
            using (SqlConnection con = new SqlConnection(connection_string))
            {
                using (SqlCommand cmd = new SqlCommand(query))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
        }



        public DataTable getWhere(string tableName, KeyValuePair<string, Object> id)
        {
            using (SqlConnection con = new SqlConnection(connection_string))
            {
                using (SqlCommand cmd = new SqlCommand(@"SELECT * FROM " + tableName + " WHERE " + id.Key + "=" + "'" + id.Value + "'"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
        }


        public void insertData(string table_name, Dictionary<string, Object> table_data)
        {
            insert_query = "INSERT INTO " + table_name + " (";

            foreach (KeyValuePair<string, Object> data in table_data)
            {
                insert_query += data.Key;
                insert_query += ",";
            }
            insert_query = insert_query.Remove(insert_query.Length - 1);
            insert_query += ") VALUES(";
            foreach (KeyValuePair<string, Object> data in table_data)
            {
                if (data.Value.ToString() == "newid()")
                {
                    insert_query += data.Value;
                    insert_query += ",";
                    continue;
                }
                    

                insert_query += "@";
                insert_query += data.Key;
                insert_query += ",";
            }
            insert_query = insert_query.Remove(insert_query.Length - 1);
            insert_query += ")";

            sqlConnection = new SqlConnection(connection_string);
            sqlConnection.Open();
            command = new SqlCommand(insert_query, sqlConnection);

            foreach (KeyValuePair<string, Object> data in table_data)
            {
                if (data.Value.ToString() == "newid()")
                {
                    continue;
                }
                command.Parameters.AddWithValue(data.Key, data.Value);
            }

            command.ExecuteNonQuery();
            command.Dispose();

            sqlConnection.Close();

        }


        public void updateData(string table_name, Dictionary<string, Object> table_data, KeyValuePair<string, Object> id)
        {
            update_query = "UPDATE " + table_name + " SET ";
            foreach (KeyValuePair<string, Object> data in table_data)
            {
                update_query += data.Key + "=@" + data.Key + ", ";
            }
            update_query = update_query.Remove(update_query.Length - 2);
            if (id.Value.ToString().All(char.IsDigit) && id.Value.ToString().Length < 10 && id.Value.ToString()[0] != '0')
            {
                update_query += " WHERE " + id.Key + "=" + id.Value;
            }
            else
            {
                update_query += " WHERE " + id.Key + "=" + "'" + id.Value + "'";
            }


            sqlConnection = new SqlConnection(connection_string);
            sqlConnection.Open();
            command = new SqlCommand(update_query, sqlConnection);

            foreach (KeyValuePair<string, Object> data in table_data)
            {
                command.Parameters.AddWithValue(data.Key, data.Value);
            }

            command.ExecuteNonQuery();
            command.Dispose();
            sqlConnection.Close();

        }

        public void deleteData(string table_name, KeyValuePair<string, string> id)
        {
            delete_query = "DELETE FROM " + table_name;
            if (id.Value.ToString().All(char.IsDigit) && id.Value.ToString().Length < 10)
            {
                delete_query += " WHERE " + id.Key + "=" + id.Value;
            }
            else
            {
                delete_query += " WHERE " + id.Key + "='" + id.Value + "'";
            }
            sqlConnection = new SqlConnection(connection_string);
            sqlConnection.Open();

            command = new SqlCommand(delete_query, sqlConnection);
            command.ExecuteNonQuery();
            command.Dispose();
            sqlConnection.Close();


        }

        public DataTable selectAllActiveData(string table_name)
        {
            using (SqlConnection con = sqlConnection)
            {
                using (SqlCommand cmd = new SqlCommand(@"SELECT * FROM " + table_name + " WHERE active = 1"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
        }

        public DataTable selectAllOrderedActiveData(string table_name, string seq_id)
        {
            using (SqlConnection con = sqlConnection)
            {
                using (SqlCommand cmd = new SqlCommand(@"SELECT * FROM " + table_name + " WHERE active = 1 ORDER BY "+seq_id+" ASC"))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter())
                    {
                        cmd.Connection = con;
                        sda.SelectCommand = cmd;
                        using (DataTable dt = new DataTable())
                        {
                            sda.Fill(dt);
                            return dt;
                        }
                    }
                }
            }
        }



        public int getLatestId(string table_name, string seq_id)
        {
            string latestId;
            SqlConnection idCon;
            idCon = new SqlConnection(connection_string);
            idCon.Open();
            SqlDataReader dr;
            SqlCommand cmd = new SqlCommand("SELECT MAX(" + seq_id + ") as last_id FROM " + table_name, idCon);

            if (cmd.ExecuteScalar() == null)
            {
                idCon.Close();
                return 1;
            }

            else
            {
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    if (dr["last_id"] == null || dr["last_id"].ToString() == "")
                    {
                        dr.Close();
                        return 1;
                    }
                    else
                    {
                        latestId = dr["last_id"].ToString();
                        dr.Close();
                        int new_id = Convert.ToInt32(latestId) + 1;
                        return new_id;
                    }

                }
                dr.Close();
                return 0;
            }
                

        }


        public string getLatestData(string table_name, string target_id, string target_seq)
        {
            SqlConnection idCon = new SqlConnection(connection_string);
            idCon.Open();
            SqlDataReader dr;
            SqlCommand cmd = new SqlCommand("SELECT TOP 1 * FROM "+table_name+" ORDER BY "+target_seq+" DESC", idCon);

            if (cmd.ExecuteScalar() == null)
            {
                idCon.Close();
                return "";
            }

            dr = cmd.ExecuteReader();
            while(dr.Read())
            {
                if (dr[target_id] != null)
                    return dr[target_id].ToString();
                else
                    return "";
            }

            return "";
        }
    }
}