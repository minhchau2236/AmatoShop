using PSCPortal.Framework;
using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using System.Text;

namespace PSCPortal.DB.Helper
{
    public static class Photo
    {
        public static new string ConnectionStringName
        {
            get
            {
                return "PSCPortalConnectionStringAmatoImage";
            }
        }
        public static string quote(string inputString)
        {
            if (inputString == null || inputString== String.Empty)
            {
                return "\"\"";
            }

            char c = '0';
            int i;
            int len = inputString.Length;
            StringBuilder sb = new StringBuilder(len + 4);
            String t;

         
            for (i = 0; i < len; i += 1)
            {
                c = inputString.ElementAt(i);
                switch (c)
                {
                    case '\\':
                    case '"':
                        sb.Append('\\');
                        sb.Append(c);
                        break;
                    case '/':
                        //                if (b == '<') {
                        sb.Append('\\');
                        //                }
                        sb.Append(c);
                        break;
                    case '\b':
                        sb.Append("\\b");
                        break;
                    case '\t':
                        sb.Append("\\t");
                        break;
                    case '\n':
                        sb.Append("\\n");
                        break;
                    case '\f':
                        sb.Append("\\f");
                        break;
                    case '\r':
                        sb.Append("\\r");
                        break;
                    default:
                        {
                            if (c < ' ')
                            {
                                //t = "000" + inputString.t(c);
                                //sb.Append("\\u" + inputString.Append(t.Length - 4));
                            }
                            else
                            {
                                sb.Append(c);
                            }
                        }
                        break;
                }
            }
     
            return sb.ToString();
        }
        public static byte[] GetImage(int id)
        {
            Database database = new Database(ConnectionStringName);
            byte[] result = null;
            using (DbConnection connection = database.GetConnection())
            {
                DbCommand command = database.GetCommand();
                #region ArticleId
                DbParameter prId = database.GetParameter(System.Data.DbType.Int32, "@PhotoId", id);
                command.Parameters.Add(prId);
                #endregion

                command.CommandText = @"SELECT TOP 1 [ContentData] FROM dbo.[BabyContents] where [ContentID]=@PhotoId";
                command.CommandType = System.Data.CommandType.Text;

                command.Connection = connection;
                connection.Open();
                DbDataReader reader = command.ExecuteReader();

                if (reader.Read() && !reader.IsDBNull(reader.GetOrdinal("ContentData")))
                    result = (byte[])reader["ContentData"];


            }
            return result;
        }
    }
}
