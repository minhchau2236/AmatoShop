using System;
using PSCPortal.Framework;
using System.Data.Common;
namespace PSCPortal.CMS.Amato
{
    [Serializable]
    public class ProtletProductsDisplayCollection : BusinessObjectCollection<ProtletProductsDisplayCollection, ProtletProductsDisplay>
    {
        private ProtletProductsDisplayCollection()
        {
        }

        protected override DbCommand GetSelectAllCommand()
        {
            Database database = new Database(ConnectionStringName);
            DbCommand command = database.GetCommand();
            command.CommandText = "SELECT [DataId],[ProductId],[OrderNumber] FROM[BABYP].[dbo].[PortletProductsDisplay]";
            return command;
        }

        public static ProtletProductsDisplayCollection GetProtletProductsDisplayCollection()
        {
            Database database = new Database(ConnectionStringName);
            ProtletProductsDisplayCollection result = new ProtletProductsDisplayCollection();
            using (DbConnection connection = database.GetConnection())
            {
                DbCommand command = result.GetSelectAllCommand();
                command.Connection = connection;
                connection.Open();
                DbDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    ProtletProductsDisplay item = new ProtletProductsDisplay(reader);
                    result.Add(item);
                }
            }
            return result;
        }
        public static ProtletProductsDisplayCollection GetProtletProductsDisplayCollectionByDataId(Guid DataId)
        {
            Database database = new Database(ConnectionStringName);
            ProtletProductsDisplayCollection result = new ProtletProductsDisplayCollection();
            using (DbConnection connection = database.GetConnection())
            {
                DbCommand command = database.GetCommand();
                DbParameter prDataId = database.GetParameter();
                prDataId.DbType = System.Data.DbType.Guid;
                prDataId.Direction = System.Data.ParameterDirection.InputOutput;
                prDataId.ParameterName = "@DataId";
                prDataId.Value = DataId;
                command.Parameters.Add(prDataId);
                command.CommandText = @"SELECT [DataId],[ProductId],[OrderNumber] FROM[BABYP].[dbo].[PortletProductsDisplay]
                                        Where DataId=@DataId 
                                        order by OrderNumber";
                command.Connection = connection;
                connection.Open();
                DbDataReader reader = command.ExecuteReader();
                while (reader.Read())
                {
                    ProtletProductsDisplay item = new ProtletProductsDisplay(reader);
                    result.Add(item);
                }
            }
            return result;
        }
        protected static new string ConnectionStringName
        {
            get
            {
                return "PSCPortalConnectionString";
            }
        }
    }
}