using System;
using System.Web;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Common;
using PSCPortal.Framework;
using System.Data.SqlClient;
using System.Data;

namespace PSCPortal.CMS
{
    [Serializable]
    public class Contractor : PSCPortal.Framework.BusinessObject<Contractor>
    {
        #region  Properties
        // Contractor --------------------------------------- 
        public Guid ContractorId { get; set; }

        public string ContractorName { get; set; }

        public string ContractorNumber { get; set; }

        public string TaxCode { get; set; }

        public string BusinessCategory { get; set; }

        public int Size { get; set; }

        public float Capital { get; set; }

        public string ContractorPhoneNumber { get; set; }

        public string Fax { get; set; }

        public string ContractorAddress { get; set; }

        public string ContractorProvinces { get; set; }

        public string ContractorNation { get; set; }

        public string WebSite { get; set; }

        public string ContractorEmail { get; set; }
        // -------------------------------------------------- 

        // User --------------------------------------------- 
        public string UserName { get; set; }

        public string Password { get; set; }

        public string UserEmail { get; set; }

        public string FirstName { get; set; }

        public string LastName { get; set; }

        public string UserPhoneNumber { get; set; }

        public string IndentityCard { get; set; }

        public bool Gender { get; set; }

        public DateTime BirthDay { get; set; }

        public string UserAddress { get; set; }

        public string UserProvinces { get; set; }

        public string UserNation { get; set; }

        public string Position { get; set; }

        public string Department { get; set; }
        // -------------------------------------------------- 

        // 0: Chưa được duyệt | 1: Bình thường | -1: Bị khóa 
        public int State { get; set; }

        public string ApprovedCode { get; set; }

        public bool IsDelete { get; set; }
        #endregion

        #region Constructions
        public Contractor()
            : base()
        {
        }

        public Contractor(DbDataReader reader)
            : base(reader)
        {
        }
        #endregion

        #region Abstract Methods
        protected override void MappingData(System.Data.Common.DbDataReader reader)
        {
            // Contractor 
            this.ContractorId = (Guid)reader["ContractorId"];
            this.ContractorName = (string)reader["ContractorName"];
            this.ContractorNumber = (string)reader["ContractorNumber"];
            this.TaxCode = (string)reader["TaxCode"];
            this.BusinessCategory = (string)reader["BusinessCategory"];
            this.Size = (int)reader["Size"];
            this.Capital = (float)reader["Capital"];
            this.ContractorPhoneNumber = (string)reader["ContractorPhoneNumber"];
            this.Fax = (string)reader["Fax"];
            this.ContractorAddress = (string)reader["ContractorAddress"];
            this.ContractorProvinces = (string)reader["ContractorProvinces"];
            this.ContractorNation = (string)reader["ContractorNation"];
            this.WebSite = (string)reader["WebSite"];
            this.ContractorEmail = (string)reader["ContractorEmail"];
            // User 
            this.UserName = (string)reader["UserName"];
            this.Password = (string)reader["Password"];
            this.UserEmail = (string)reader["UserEmail"];
            this.FirstName = (string)reader["FirstName"];
            this.LastName = (string)reader["LastName"];
            this.UserPhoneNumber = (string)reader["UserPhoneNumber"];
            this.IndentityCard = (string)reader["IndentityCard"];
            this.Gender = (bool)reader["Gender"];
            this.BirthDay = (DateTime)reader["BirthDay"];
            this.UserAddress = (string)reader["UserAddress"];
            this.UserProvinces = (string)reader["UserProvinces"];
            this.UserNation = (string)reader["UserNation"];
            this.Position = (string)reader["Position"];
            this.Department = (string)reader["Department"];
            // 
            this.State = (int)reader["State"];
            this.ApprovedCode = (string)reader["ApprovedCode"];
            this.IsDelete = (bool)reader["IsDelete"];
        }

        protected override System.Data.Common.DbCommand GetInsertCommand()
        {
            Database database = new Database(ConnectionStringName);
            DbCommand command = database.GetCommand();

            #region ContractorId
            DbParameter prContractorId = database.GetParameter(System.Data.DbType.Guid, "@ContractorId", this.ContractorId);
            command.Parameters.Add(prContractorId);
            #endregion

            #region ContractorName
            DbParameter prContractorName = database.GetParameter(System.Data.DbType.String, "@ContractorName", this.ContractorName);
            command.Parameters.Add(prContractorName);
            #endregion

            #region ContractorNumber
            DbParameter prContractorNumber = database.GetParameter(System.Data.DbType.String, "@ContractorNumber", this.ContractorNumber);
            command.Parameters.Add(prContractorNumber);
            #endregion

            #region TaxCode
            DbParameter prTaxCode = database.GetParameter(System.Data.DbType.String, "@TaxCode", this.TaxCode);
            command.Parameters.Add(prTaxCode);
            #endregion

            #region BusinessCategory
            DbParameter prBusinessCategory = database.GetParameter(System.Data.DbType.String, "@BusinessCategory", this.BusinessCategory);
            command.Parameters.Add(prBusinessCategory);
            #endregion

            #region Size
            DbParameter prSize = database.GetParameter(System.Data.DbType.Int16, "@Size", this.Size);
            command.Parameters.Add(prSize);
            #endregion

            #region Capital
            DbParameter prCapital = database.GetParameter(System.Data.DbType.Double, "@Capital", this.Capital);
            command.Parameters.Add(prCapital);
            #endregion

            #region ContractorPhoneNumber
            DbParameter prContractorPhoneNumber = database.GetParameter(System.Data.DbType.String, "@ContractorPhoneNumber", this.ContractorPhoneNumber);
            command.Parameters.Add(prContractorPhoneNumber);
            #endregion

            #region Fax
            DbParameter prFax = database.GetParameter(System.Data.DbType.String, "@Fax", this.Fax);
            command.Parameters.Add(prFax);
            #endregion

            #region ContractorAddress
            DbParameter prContractorAddress = database.GetParameter(System.Data.DbType.String, "@ContractorAddress", this.ContractorAddress);
            command.Parameters.Add(prContractorAddress);
            #endregion

            #region ContractorProvinces
            DbParameter prContractorProvinces = database.GetParameter(System.Data.DbType.String, "@ContractorProvinces", this.ContractorProvinces);
            command.Parameters.Add(prContractorProvinces);
            #endregion

            #region ContractorNation
            DbParameter prContractorNation = database.GetParameter(System.Data.DbType.String, "@ContractorNation", this.ContractorNation);
            command.Parameters.Add(prContractorNation);
            #endregion

            #region WebSite
            DbParameter prWebSite = database.GetParameter(System.Data.DbType.String, "@WebSite", this.WebSite);
            command.Parameters.Add(prWebSite);
            #endregion

            #region ContractorEmail
            DbParameter prContractorEmail = database.GetParameter(System.Data.DbType.String, "@ContractorEmail", this.ContractorEmail);
            command.Parameters.Add(prContractorEmail);
            #endregion

            #region UserName
            DbParameter prUserName = database.GetParameter(System.Data.DbType.String, "@UserName", this.UserName);
            command.Parameters.Add(prUserName);
            #endregion

            #region Password
            DbParameter prPassword = database.GetParameter(System.Data.DbType.String, "@Password", this.Password);
            command.Parameters.Add(prPassword);
            #endregion

            #region UserEmail
            DbParameter prUserEmail = database.GetParameter(System.Data.DbType.String, "@UserEmail", this.UserEmail);
            command.Parameters.Add(prUserEmail);
            #endregion

            #region FirstName
            DbParameter prFirstName = database.GetParameter(System.Data.DbType.String, "@FirstName", this.FirstName);
            command.Parameters.Add(prFirstName);
            #endregion

            #region LastName
            DbParameter prLastName = database.GetParameter(System.Data.DbType.String, "@LastName", this.LastName);
            command.Parameters.Add(prLastName);
            #endregion

            #region UserPhoneNumber
            DbParameter prUserPhoneNumber = database.GetParameter(System.Data.DbType.String, "@UserPhoneNumber", this.UserPhoneNumber);
            command.Parameters.Add(prUserPhoneNumber);
            #endregion

            #region IndentityCard
            DbParameter prIndentityCard = database.GetParameter(System.Data.DbType.String, "@IndentityCard", this.IndentityCard);
            command.Parameters.Add(prIndentityCard);
            #endregion

            #region Gender
            DbParameter prGender = database.GetParameter(System.Data.DbType.Boolean, "@Gender", this.Gender);
            command.Parameters.Add(prGender);
            #endregion

            #region BirthDay
            DbParameter prBirthDay = database.GetParameter(System.Data.DbType.DateTime, "@BirthDay", this.BirthDay);
            command.Parameters.Add(prBirthDay);
            #endregion

            #region UserAddress
            DbParameter prUserAddress = database.GetParameter(System.Data.DbType.String, "@UserAddress", this.UserAddress);
            command.Parameters.Add(prUserAddress);
            #endregion

            #region UserProvinces
            DbParameter prUserProvinces = database.GetParameter(System.Data.DbType.String, "@UserProvinces", this.UserProvinces);
            command.Parameters.Add(prUserProvinces);
            #endregion

            #region UserNation
            DbParameter prUserNation = database.GetParameter(System.Data.DbType.String, "@UserNation", this.UserNation);
            command.Parameters.Add(prUserNation);
            #endregion

            #region Position
            DbParameter prPosition = database.GetParameter(System.Data.DbType.String, "@Position", this.Position);
            command.Parameters.Add(prPosition);
            #endregion

            #region Department
            DbParameter prDepartment = database.GetParameter(System.Data.DbType.String, "@Department", this.Department);
            command.Parameters.Add(prDepartment);
            #endregion

            #region State
            DbParameter prState = database.GetParameter(System.Data.DbType.Int16, "@State", this.State);
            command.Parameters.Add(prState);
            #endregion

            #region ApprovedCode
            DbParameter prApprovedCode = database.GetParameter(System.Data.DbType.String, "@ApprovedCode", this.ApprovedCode);
            command.Parameters.Add(prApprovedCode);
            #endregion

            #region IsDelete
            DbParameter prIsDelete = database.GetParameter(System.Data.DbType.Boolean, "@IsDelete", this.IsDelete);
            command.Parameters.Add(prIsDelete);
            #endregion

            #region Command Insert Data
            command.CommandText = "Contractor_Insert";
            command.CommandType = System.Data.CommandType.StoredProcedure;
            #endregion

            return command;
        }

        public bool CreateContractor()
        {
            try
            {
                Database db = new Database(ConnectionStringName);

                DbCommand cmd = GetInsertCommand();

                DbConnection cnn = db.GetConnection();

                cmd.Connection = cnn;

                cnn.Open();
                int effectRows = cmd.ExecuteNonQuery();

                cnn.Close();

                return effectRows > 0;
            }
            catch
            {
                return false;
            }
        }

        protected override System.Data.Common.DbCommand GetUpdateCommand()
        {
            Database database = new Database(ConnectionStringName);
            DbCommand command = database.GetCommand();

            #region ContractorId
            DbParameter prContractorId = database.GetParameter(System.Data.DbType.Guid, "@ContractorId", this.ContractorId);
            command.Parameters.Add(prContractorId);
            #endregion

            #region ContractorName
            DbParameter prContractorName = database.GetParameter(System.Data.DbType.String, "@ContractorName", this.ContractorName);
            command.Parameters.Add(prContractorName);
            #endregion

            #region TaxCode
            DbParameter prTaxCode = database.GetParameter(System.Data.DbType.String, "@TaxCode", this.TaxCode);
            command.Parameters.Add(prTaxCode);
            #endregion

            #region BusinessCategory
            DbParameter prBusinessCategory = database.GetParameter(System.Data.DbType.String, "@BusinessCategory", this.BusinessCategory);
            command.Parameters.Add(prBusinessCategory);
            #endregion

            #region Size
            DbParameter prSize = database.GetParameter(System.Data.DbType.Int16, "@Size", this.Size);
            command.Parameters.Add(prSize);
            #endregion

            #region Capital
            DbParameter prCapital = database.GetParameter(System.Data.DbType.Double, "@Capital", this.Capital);
            command.Parameters.Add(prCapital);
            #endregion

            #region ContractorPhoneNumber
            DbParameter prContractorPhoneNumber = database.GetParameter(System.Data.DbType.String, "@ContractorPhoneNumber", this.ContractorPhoneNumber);
            command.Parameters.Add(prContractorPhoneNumber);
            #endregion

            #region Fax
            DbParameter prFax = database.GetParameter(System.Data.DbType.String, "@Fax", this.Fax);
            command.Parameters.Add(prFax);
            #endregion

            #region ContractorAddress
            DbParameter prContractorAddress = database.GetParameter(System.Data.DbType.String, "@ContractorAddress", this.ContractorAddress);
            command.Parameters.Add(prContractorAddress);
            #endregion

            #region ContractorProvinces
            DbParameter prContractorProvinces = database.GetParameter(System.Data.DbType.String, "@ContractorProvinces", this.ContractorProvinces);
            command.Parameters.Add(prContractorProvinces);
            #endregion

            #region ContractorNation
            DbParameter prContractorNation = database.GetParameter(System.Data.DbType.String, "@ContractorNation", this.ContractorNation);
            command.Parameters.Add(prContractorNation);
            #endregion

            #region WebSite
            DbParameter prWebSite = database.GetParameter(System.Data.DbType.String, "@WebSite", this.WebSite);
            command.Parameters.Add(prWebSite);
            #endregion

            #region ContractorEmail
            DbParameter prContractorEmail = database.GetParameter(System.Data.DbType.String, "@ContractorEmail", this.ContractorEmail);
            command.Parameters.Add(prContractorEmail);
            #endregion

            #region UserEmail
            DbParameter prUserEmail = database.GetParameter(System.Data.DbType.String, "@UserEmail", this.UserEmail);
            command.Parameters.Add(prUserEmail);
            #endregion

            #region FirstName
            DbParameter prFirstName = database.GetParameter(System.Data.DbType.String, "@FirstName", this.FirstName);
            command.Parameters.Add(prFirstName);
            #endregion

            #region LastName
            DbParameter prLastName = database.GetParameter(System.Data.DbType.String, "@LastName", this.LastName);
            command.Parameters.Add(prLastName);
            #endregion

            #region UserPhoneNumber
            DbParameter prUserPhoneNumber = database.GetParameter(System.Data.DbType.String, "@UserPhoneNumber", this.UserPhoneNumber);
            command.Parameters.Add(prUserPhoneNumber);
            #endregion

            #region IndentityCard
            DbParameter prIndentityCard = database.GetParameter(System.Data.DbType.String, "@IndentityCard", this.IndentityCard);
            command.Parameters.Add(prIndentityCard);
            #endregion

            #region Gender
            DbParameter prGender = database.GetParameter(System.Data.DbType.Boolean, "@Gender", this.Gender);
            command.Parameters.Add(prGender);
            #endregion

            #region BirthDay
            DbParameter prBirthDay = database.GetParameter(System.Data.DbType.DateTime, "@BirthDay", this.BirthDay);
            command.Parameters.Add(prBirthDay);
            #endregion

            #region UserAddress
            DbParameter prUserAddress = database.GetParameter(System.Data.DbType.String, "@UserAddress", this.UserAddress);
            command.Parameters.Add(prUserAddress);
            #endregion

            #region UserProvinces
            DbParameter prUserProvinces = database.GetParameter(System.Data.DbType.String, "@UserProvinces", this.UserProvinces);
            command.Parameters.Add(prUserProvinces);
            #endregion

            #region UserNation
            DbParameter prUserNation = database.GetParameter(System.Data.DbType.String, "@UserNation", this.UserNation);
            command.Parameters.Add(prUserNation);
            #endregion

            #region Position
            DbParameter prPosition = database.GetParameter(System.Data.DbType.String, "@Position", this.Position);
            command.Parameters.Add(prPosition);
            #endregion

            #region Department
            DbParameter prDepartment = database.GetParameter(System.Data.DbType.String, "@Department", this.Department);
            command.Parameters.Add(prDepartment);
            #endregion

            #region Command Insert Data
            command.CommandText = "Contractor_Update";
            command.CommandType = System.Data.CommandType.StoredProcedure;
            #endregion

            return command;
        }

        protected override System.Data.Common.DbCommand GetDeleteCommand()
        {
            Database database = new Database(ConnectionStringName);
            DbCommand command = database.GetCommand();

            #region ContractorId
            DbParameter prContractorId = database.GetParameter(System.Data.DbType.Guid, "@ContractorId", this.ContractorId);
            command.Parameters.Add(prContractorId);
            #endregion

            #region Command Insert Data
            command.CommandText = "Contractor_Delete";
            command.CommandType = System.Data.CommandType.StoredProcedure;
            #endregion

            return command;
        }

        protected static new string ConnectionStringName
        {
            get
            {
                return "PSCPortalConnectionString2";
            }
        }
        #endregion
    }
}