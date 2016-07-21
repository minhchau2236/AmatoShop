<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SignUp.ascx.cs" Inherits="PSCPortal.Modules.Contractor.SignUp" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<%--http://dev.com:44300/module/dang-ky-nha-thau/7706bcb4-34ba-4be5-840c-07099b8ede75--%>
<style type="text/css">
    #divMain {
        margin-top: 80px;
    }




        #divMain input[type=text] {
            padding: 0 2px 0 2px;
        }




        #divMain .ipText {
            width: 100%;
        }




        #divMain input[type=button] {
            padding: 0 10px 0 10px;
        }




        #divMain input[type=password] {
            padding: 0 2px 0 2px;
            width: 178px;
        }




        #divMain select {
            padding: 2px 2px 2px 2px;
            width: 180px;
        }




    .divTitle {
        color: black;
        font-size: 18px;
        font-weight: bold;
        padding-bottom: 5px;
    }




    .tbContent {
        width: 680px;
        border-spacing: 2px;
        border-collapse: separate;
        border-top: 5px solid #2788BB;
        border-bottom: 5px solid #2788BB;
    }




        .tbContent tr td {
            padding: 7px 5px 7px 5px;
            background-color: #CCE5FF;
        }




            .tbContent tr td a {
                color: red;
            }




            .tbContent tr td .aTrans {
                color: transparent;
            }




        .tbContent tr .tdTitle {
            background-color: #E0E0E0;
            width: 180px;
        }




    .divCommand {
        width: 680px;
        text-align: center;
        margin-top: 15px;
    }




        .divCommand input[type=button] {
            background-color: #2788BB;
            color: white;
            border: none;
            min-height: 25px;
            min-width: 100px;
        }
</style>
<script type="text/javascript">
    var pageObject = {
        divContractor: null,
        divUser: null
    }




    var infoContractor = {
        TaxCode: null,
        ContractorName: null,
        BusinessCategory: null,
        Size: null,
        Capital: null,
        ContractorPhoneNumber: null,
        Fax: null,
        ContractorAddress: null,
        ContractorProvinces: null,
        ContractorNation: null,
        WebSite: null,
        ContractorEmail: null
    }




    function IsNullOrWhiteSpace(value) {
        if (value == null) return true;
        return value.replace(/\s/g, '').length == 0;
    }




    var checkInfoContractor, statusInfoContractor;
    function Get_infoContractor() {
        checkInfoContractor = true;
        statusInfoContractor = '';


        infoContractor.TaxCode = document.getElementById('txtTaxCode').value;
        if (IsNullOrWhiteSpace(infoContractor.TaxCode)) {
            checkInfoContractor = false;
            statusInfoContractor += '   - Mã số thuế\n';
        }


        infoContractor.ContractorName = document.getElementById('txtContractorName').value;
        if (IsNullOrWhiteSpace(infoContractor.ContractorName)) {
            checkInfoContractor = false;
            statusInfoContractor += '   - Tên tổ chức / cơ quan\n';
        }


        infoContractor.BusinessCategory = document.getElementById('oppBusinessCategory').value;


        infoContractor.Size = document.getElementById('txtSize').value;
        if (IsNullOrWhiteSpace(infoContractor.Size)) {
            checkInfoContractor = false;
            statusInfoContractor += '   - Số nhân viên\n';
        }


        infoContractor.Capital = document.getElementById('txtCapital').value;
        if (IsNullOrWhiteSpace(infoContractor.Capital)) {
            checkInfoContractor = false;
            statusInfoContractor += '   - Vốn điều lệ\n';
        }


        infoContractor.ContractorPhoneNumber = document.getElementById('txtContractorPhoneNumber').value;
        if (IsNullOrWhiteSpace(infoContractor.ContractorPhoneNumber)) {
            checkInfoContractor = false;
            statusInfoContractor += '   - Số điện thoại\n';
        }


        infoContractor.Fax = document.getElementById('txtFax').value;
        if (IsNullOrWhiteSpace(infoContractor.Fax)) {
            checkInfoContractor = false;
            statusInfoContractor += '   - Số Fax\n';
        }


        infoContractor.ContractorAddress = document.getElementById('txtContractorAddress').value;
        if (IsNullOrWhiteSpace(infoContractor.ContractorAddress)) {
            checkInfoContractor = false;
            statusInfoContractor += '   - Địa chỉ\n';
        }


        infoContractor.ContractorProvinces = document.getElementById('oppContractorProvinces').value;


        infoContractor.ContractorNation = document.getElementById('oppContractorNation').value;


        infoContractor.WebSite = document.getElementById('txtWebSite').value;


        infoContractor.ContractorEmail = document.getElementById('txtContractorEmail').value;
    }




    var infoUser = {
        UserName: null,
        Password: null,
        cfPassword: null,
        FirstName: null,
        LastName: null,
        UserPhoneNumber: null,
        IndentityCard: null,
        Gender: null,
        BirthDay: null,
        UserAddress: null,
        UserProvinces: null,
        UserNation: null,
        Position: null
    }




    var checkInfoUser, statusInfoUser;
    function Get_infoUser() {
        checkInfoUser = true;
        statusInfoUser = '';


        infoUser.UserName = document.getElementById('txtUserName').value;
        if (IsNullOrWhiteSpace(infoUser.UserName)) {
            checkInfoUser = false;
            statusInfoUser += '   - Tên đăng nhập\n';
        }


        infoUser.Password = document.getElementById('txtPassword').value;
        if (IsNullOrWhiteSpace(infoUser.Password)) {
            checkInfoUser = false;
            statusInfoUser += '   - Mật khẩu\n';
        }


        infoUser.cfPassword = document.getElementById('txtConfirmPassword').value;
        if (infoUser.Password != infoUser.cfPassword) {
            checkInfoUser = false;
            statusInfoUser += '   - Mật khẩu xác nhận không trùng với mật khẩu\n';
        }


        infoUser.FirstName = document.getElementById('txtFirstName').value;
        if (IsNullOrWhiteSpace(infoUser.FirstName)) {
            checkInfoUser = false;
            statusInfoUser += '   - Họ\n';
        }


        infoUser.LastName = document.getElementById('txtLastName').value;
        if (IsNullOrWhiteSpace(infoUser.LastName)) {
            checkInfoUser = false;
            statusInfoUser += '   - Tên\n';
        }


        infoUser.UserPhoneNumber = document.getElementById('txtUserPhoneNumber').value;
        if (IsNullOrWhiteSpace(infoUser.UserPhoneNumber)) {
            checkInfoUser = false;
            statusInfoUser += '   - Số điện thoại\n';
        }


        infoUser.IndentityCard = document.getElementById('txtIndentityCard').value;


        infoUser.Gender = document.querySelector('input[name="gender"]:checked').value;


        infoUser.BirthDay = $find("<%= rdpBirthDay.ClientID %>").get_selectedDate();


        infoUser.UserAddress = document.getElementById('txtUserAddress').value;


        infoUser.UserProvinces = document.getElementById('oppUserProvinces').value;


        infoUser.UserNation = document.getElementById('oppUserNation').value;


        infoUser.Position = document.getElementById('txtPosition').value;
    }




    function Initialize() {
        pageObject.divContractor = document.getElementById('divContractor');
        pageObject.divUser = document.getElementById('divUser');
    }




    function btNext_onclick() {
        Get_infoContractor();
        if (checkInfoContractor) {
            pageObject.divContractor.style.display = "none";
            pageObject.divUser.style.display = "block";
            window.scrollTo(0, 200);
        }
        else {
            alert('Bạn vui lòng nhập đầy đủ các thông tin sau :\n\n' + statusInfoContractor);
        }
    }




    function btBack_onclick() {
        pageObject.divUser.style.display = "none";
        pageObject.divContractor.style.display = "block";
        window.scrollTo(0, 200);
    }




    function btSignUp_onclick() {
        Get_infoUser();
        if (checkInfoUser) {
            PSCPortal.Services.CMS.CreateContractor(infoContractor.ContractorName, infoContractor.TaxCode, infoContractor.BusinessCategory, infoContractor.Size, infoContractor.Capital, infoContractor.ContractorPhoneNumber, infoContractor.Fax, infoContractor.ContractorAddress, infoContractor.ContractorProvinces, infoContractor.ContractorNation, infoContractor.WebSite, infoContractor.ContractorEmail, infoUser.UserName, infoUser.Password, infoUser.UserEmail, infoUser.FirstName, infoUser.LastName, infoUser.UserPhoneNumber, infoUser.IndentityCard, infoUser.Gender, infoUser.BirthDay, infoUser.UserAddress, infoUser.UserProvinces, infoUser.UserNation,
                CallCreateContractorSuccess, CallWebMethodFailed);
        }
        else {
            alert('Bạn vui lòng nhập đầy đủ các thông tin sau :\n\n' + statusInfoUser);
        }
    }

    function CallCreateContractorSuccess(results, context, methodName) {
        alert('Thêm thành công !' + results);
    }

    function CallWebMethodFailed(results, context, methodName) {
        radalert(results._message);
    }

    function pageLoad() {
        Initialize();
        pageObject.divUser.style.display = "none";
    }
</script>
<div id="divMain">
    <div id="divContractor">
        <div class="divTitle">Thông tin tổ chức / cơ quan</div>
        <table class="tbContent">
            <tr>
                <td class="tdTitle"><a>*</a> Mã số thuế</td>
                <td>
                    <input type="text" id="txtTaxCode" />
                    <input type="button" id="btCheckTaxCode" value="Kiểm tra" />
                </td>
            </tr>
            <tr>
                <td class="tdTitle"><a>*</a> Tên tổ chức / cơ quan</td>
                <td>
                    <input type="text" id="txtContractorName" class="ipText" /></td>
            </tr>
            <tr>
                <td class="tdTitle"><a>*</a> Loại hình kinh doanh</td>
                <td>
                    <select id="oppBusinessCategory">
                        <option value="Doanh nghiệp tư nhân">Doanh nghiệp tư nhân</option>
                        <option value="Doanh nghiệp nhà nước">Doanh nghiệp nhà nước</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="tdTitle"><a>*</a> Số nhân viên</td>
                <td>
                    <input type="text" id="txtSize" /></td>
            </tr>
            <tr>
                <td class="tdTitle"><a>*</a> Vốn điều lệ</td>
                <td>
                    <input type="text" id="txtCapital" /></td>
            </tr>
            <tr>
                <td class="tdTitle"><a>*</a> Số điện thoại</td>
                <td>
                    <input type="text" id="txtContractorPhoneNumber" /></td>
            </tr>
            <tr>
                <td class="tdTitle"><a>*</a> Số Fax</td>
                <td>
                    <input type="text" id="txtFax" /></td>
            </tr>
            <tr>
                <td class="tdTitle"><a>*</a> Địa chỉ</td>
                <td>
                    <input type="text" id="txtContractorAddress" class="ipText" /></td>
            </tr>
            <tr>
                <td class="tdTitle"><a>*</a> Tỉnh thành</td>
                <td>
                    <select id="oppContractorProvinces">
                        <option value="Thành phố Hồ Chí Minh">Thành phố Hồ Chí Minh</option>
                        <option value="Hà Nội">Hà Nội</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="tdTitle"><a>*</a> Quốc gia</td>
                <td>
                    <select id="oppContractorNation">
                        <option value="Việt Nam">Việt Nam</option>
                        <option value="USA">USA</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="tdTitle"><a class="aTrans">*</a> Địa chị trang web</td>
                <td>
                    <input type="text" id="txtWebSite" class="ipText" /></td>
            </tr>
            <tr>
                <td class="tdTitle"><a class="aTrans">*</a> Địa chị Email</td>
                <td>
                    <input type="text" id="txtContractorEmail" class="ipText" /></td>
            </tr>
        </table>
        <div class="divCommand">
            <input type="button" id="btNext" value="Tiếp theo" onclick="btNext_onclick()" />
        </div>
    </div>
    <div id="divUser">
        <div class="divTitle">Thông tin người đại diện</div>
        <table class="tbContent">
            <tr>
                <td class="tdTitle"><a>*</a> Tên đăng nhập</td>
                <td>
                    <input type="text" id="txtUserName" />
                    <input type="button" id="btCheckUserName" value="Kiểm tra" />
                </td>
            </tr>
            <tr>
                <td class="tdTitle"><a>*</a> Mật khẩu</td>
                <td>
                    <input type="password" id="txtPassword" />
                </td>
            </tr>
            <tr>
                <td class="tdTitle"><a>*</a> Nhập lại mật khẩu</td>
                <td>
                    <input type="password" id="txtConfirmPassword" />
                </td>
            </tr>
            <tr>
                <td class="tdTitle"><a>*</a> Họ</td>
                <td>
                    <input type="text" id="txtFirstName" />
                </td>
            </tr>
            <tr>
                <td class="tdTitle"><a>*</a> Tên</td>
                <td>
                    <input type="text" id="txtLastName" />
                </td>
            </tr>
            <tr>
                <td class="tdTitle"><a>*</a> Số điện thoại</td>
                <td>
                    <input type="text" id="txtUserPhoneNumber" />
                </td>
            </tr>
            <tr>
                <td class="tdTitle"><a class="aTrans">*</a> Chức vụ</td>
                <td>
                    <input type="text" id="txtPosition" />
                </td>
            </tr>
            <tr>
                <td class="tdTitle"><a class="aTrans">*</a> Phòng ban</td>
                <td>
                    <input type="text" id="txtDepartment" />
                </td>
            </tr>
            <tr>
                <td class="tdTitle"><a class="aTrans">*</a> Số CMND</td>
                <td>
                    <input type="text" id="txtIndentityCard" />
                </td>
            </tr>
            <tr>
                <td class="tdTitle"><a class="aTrans">*</a> Giới tính</td>
                <td>
                    <input type="radio" name="gender" value="1" checked="checked">
                    Nam  
                    <input type="radio" name="gender" value="0">
                    Nữ  
                </td>
            </tr>
            <tr>
                <td class="tdTitle"><a class="aTrans">*</a> Ngày sinh</td>
                <td>
                    <telerik:RadDatePicker ID="rdpBirthDay" runat="server" DateInput-DateFormat="dd-MM-yyyy" Width="210px" Height="22px">
                    </telerik:RadDatePicker>
                </td>
            </tr>
            <tr>
                <td class="tdTitle"><a class="aTrans">*</a> Địa chỉ</td>
                <td>
                    <input type="text" id="txtUserAddress" class="ipText" /></td>
            </tr>
            <tr>
                <td class="tdTitle"><a class="aTrans">*</a> Tỉnh thành</td>
                <td>
                    <select id="oppUserProvinces">
                        <option value="Thành phố Hồ Chí Minh">Thành phố Hồ Chí Minh</option>
                        <option value="Hà Nội">Hà Nội</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="tdTitle"><a class="aTrans">*</a> Quốc gia</td>
                <td>
                    <select id="oppUserNation">
                        <option value="Việt Nam">Việt Nam</option>
                        <option value="USA">USA</option>
                    </select>
                </td>
            </tr>
        </table>
        <div class="divCommand">
            <input type="button" id="btBack" value="Quay lại" onclick="btBack_onclick()" />
            <input type="button" id="btSignUp" value="Đăng ký" onclick="btSignUp_onclick()" />
        </div>
    </div>
</div>
