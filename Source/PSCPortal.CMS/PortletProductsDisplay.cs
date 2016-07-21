using System;
using System.Data.Common;
using PSCPortal.Framework;
using PSCPortal.DB.Helper;
using PSCPortal.DB.Entities;
using NHibernate.Linq;
using PSCPortal.DB.Entities;
using System.Linq;

namespace PSCPortal.CMS.Amato
{
    [Serializable]
    public class ProtletProductsDisplay : BusinessObject<ProtletProductsDisplay>
    {
        #region Properties
        private Guid _dataId;
        public Guid DataId
        {
            get
            {
                return _dataId;
            }
            set
            {
                _dataId = value;
            }
        }

        private int _productId;
        public int ProductId
        {
            get
            {
                return _productId;
            }
            set
            {
                _productId = value;
            }
        }



        private int _orderNumber;
        public int OrderNumber
        {
            get
            {
                return _orderNumber;
            }
            set
            {
                _orderNumber = value;
            }
        }

        private string _productName;
        public string ProductName
        {
            get
            {
                return _productName;
            }
            set
            {
                _productName = value;
            }
        }

        private string _collectionName;
        public string CollectionName
        {
            get
            {
                return _collectionName;
            }
            set
            {
                _collectionName = value;
            }
        }

        #endregion

        #region Constructions
        public ProtletProductsDisplay()
        {
        }

        public ProtletProductsDisplay(DbDataReader reader)
            : base(reader)
        {
        }
        #endregion
        #region Abstract Methods
        protected override void MappingData(DbDataReader reader)
        {
            _dataId = (Guid)reader["DataId"];
            _productId = (int)reader["ProductId"];
            _orderNumber = (int)reader["OrderNumber"];
            SessionManager.DoWork(session =>
            {
                var product = session.Query<Product>().SingleOrDefault(p => p.ProductID == _productId);
                _productName = product.ProductName;
                var collection = session.Query<Collection>().SingleOrDefault(c => c.CollectionID == product.Collection.CollectionID);
                _collectionName = collection.CollectionName;
            });
        }
        protected override DbCommand GetInsertCommand()
        {
            Database database = new Database(ConnectionStringName);
            DbCommand command = database.GetCommand();
            #region TabTopicDisplayDataId
            DbParameter prDataId = database.GetParameter();
            prDataId.DbType = System.Data.DbType.Guid;
            prDataId.Direction = System.Data.ParameterDirection.InputOutput;
            prDataId.ParameterName = "@DataId";
            prDataId.Value = _dataId;
            command.Parameters.Add(prDataId);
            #endregion
            #region TabTopicDisplayProductId
            DbParameter prTopicId = database.GetParameter();
            prTopicId.DbType = System.Data.DbType.Int32;
            prTopicId.Direction = System.Data.ParameterDirection.InputOutput;
            prTopicId.ParameterName = "@ProductId";
            prTopicId.Value = _productId;
            command.Parameters.Add(prTopicId);
            #endregion

            #region TabTopicProductOrder
            DbParameter prTabOrder = database.GetParameter();
            prTabOrder.DbType = System.Data.DbType.Int32;
            prTabOrder.Direction = System.Data.ParameterDirection.InputOutput;
            prTabOrder.ParameterName = "@OrderNumber";
            prTabOrder.Value = _orderNumber;
            command.Parameters.Add(prTabOrder);
            #endregion

            #region Command Insert Data
            command.CommandText = "INSERT INTO [PortletProductsDisplay] ([DataId],[ProductId],[OrderNumber]) VALUES (@DataId,@ProductId,@OrderNumber)";
            #endregion

            return command;
        }

        protected override DbCommand GetUpdateCommand()
        {
            Database database = new Database(ConnectionStringName);
            DbCommand command = database.GetCommand();
            #region TabTopicDisplayDataId
            DbParameter prDataId = database.GetParameter();
            prDataId.DbType = System.Data.DbType.Guid;
            prDataId.Direction = System.Data.ParameterDirection.InputOutput;
            prDataId.ParameterName = "@DataId";
            prDataId.Value = _dataId;
            command.Parameters.Add(prDataId);
            #endregion
            #region TabTopicDisplayProductId
            DbParameter prTopicId = database.GetParameter();
            prTopicId.DbType = System.Data.DbType.Int32;
            prTopicId.Direction = System.Data.ParameterDirection.InputOutput;
            prTopicId.ParameterName = "@ProductId";
            prTopicId.Value = _productId;
            command.Parameters.Add(prTopicId);
            #endregion

            #region TabTopicProductOrder
            DbParameter prTabOrder = database.GetParameter();
            prTabOrder.DbType = System.Data.DbType.Int32;
            prTabOrder.Direction = System.Data.ParameterDirection.InputOutput;
            prTabOrder.ParameterName = "@OrderNumber";
            prTabOrder.Value = _orderNumber;
            command.Parameters.Add(prTabOrder);
            #endregion

            #region Command Update Data
            command.CommandText = "UPDATE [PortletProductsDisplay] SET [ProductId] = @ProductId, [OrderNumber] = @OrderNumber WHERE [DataId] = @DataId and ProductId=@ProductId";
            #endregion

            return command;
        }

        protected override DbCommand GetDeleteCommand()
        {
            Database database = new Database(ConnectionStringName);
            DbCommand command = database.GetCommand();
            #region Command Delete Data
            #region TabTopicDisplayDataId
            DbParameter prDataId = database.GetParameter();
            prDataId.DbType = System.Data.DbType.Guid;
            prDataId.Direction = System.Data.ParameterDirection.InputOutput;
            prDataId.ParameterName = "@DataId";
            prDataId.Value = _dataId;
            command.Parameters.Add(prDataId);
            #endregion
            #region TabTopicDisplayProductId
            DbParameter prTopicId = database.GetParameter();
            prTopicId.DbType = System.Data.DbType.Int32;
            prTopicId.Direction = System.Data.ParameterDirection.InputOutput;
            prTopicId.ParameterName = "@ProductId";
            prTopicId.Value = _productId;
            command.Parameters.Add(prTopicId);
            #endregion
            command.CommandText = "DELETE [PortletProductsDisplay] WHERE [DataId] = @DataId and ProductId=@ProductId";
            #endregion

            return command;
        }

        public override bool Equals(object obj)
        {
            if (obj.GetType() == typeof(ProtletProductsDisplay)
                && ((ProtletProductsDisplay)obj)._dataId == _dataId
               )
                return true;
            return false;
        }
        public override int GetHashCode()
        {
            int hashCode = 0;
            hashCode += _dataId.GetHashCode();
            return hashCode;
        }
        protected static new string ConnectionStringName
        {
            get
            {
                return "PSCPortalConnectionString";
            }
        }
        #endregion
    }
}