package 
{
    import mx.binding.*;
    import mx.core.*;
    import net.sprd.modules.share.*;

    public class _net_sprd_modules_share_SharePanelWatcherSetupUtil extends Object implements IWatcherSetupUtil2
    {

        public function _net_sprd_modules_share_SharePanelWatcherSetupUtil()
        {
            return;
        }// end function

        public function setup(param1:Object, param2:Function, param3:Function, param4:Array, param5:Array) : void
        {
            var target:* = param1;
            var propertyGetter:* = param2;
            var staticPropertyGetter:* = param3;
            var bindings:* = param4;
            var watchers:* = param5;
            watchers[41] = new PropertyWatcher("hideLogin", {propertyChange:true}, [bindings[40]], propertyGetter);
            watchers[13] = new PropertyWatcher("sendMessageButton", {propertyChange:true}, [bindings[13], bindings[17]], propertyGetter);
            watchers[14] = new PropertyWatcher("height", {heightChanged:true}, [bindings[13]], null);
            watchers[20] = new PropertyWatcher("width", {widthChanged:true}, [bindings[17]], null);
            watchers[2] = new PropertyWatcher("resourceManager", {unused:true}, [bindings[3], bindings[8], bindings[9], bindings[10], bindings[12], bindings[14], bindings[15], bindings[16], bindings[19], bindings[20], bindings[21], bindings[22], bindings[24], bindings[26], bindings[27], bindings[29], bindings[30], bindings[31], bindings[32], bindings[33], bindings[45], bindings[46], bindings[48], bindings[50], bindings[55]], propertyGetter);
            watchers[3] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.save_share"];
            }// end function
            , {change:true}, [bindings[3]], null);
            watchers[7] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.save"];
            }// end function
            , {change:true}, [bindings[8]], null);
            watchers[8] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.saving_in_progress"];
            }// end function
            , {change:true}, [bindings[9]], null);
            watchers[9] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.email"];
            }// end function
            , {change:true}, [bindings[10]], null);
            watchers[12] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.email"];
            }// end function
            , {change:true}, [bindings[12]], null);
            watchers[15] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.mail_from"];
            }// end function
            , {change:true}, [bindings[14]], null);
            watchers[17] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.mail_message"];
            }// end function
            , {change:true}, [bindings[16]], null);
            watchers[16] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.mail_to"];
            }// end function
            , {change:true}, [bindings[15]], null);
            watchers[27] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.mail_sending"];
            }// end function
            , {change:true}, [bindings[20]], null);
            watchers[26] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.mail_send_mail"];
            }// end function
            , {change:true}, [bindings[19]], null);
            watchers[29] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.mail_was_not_sent"];
            }// end function
            , {change:true}, [bindings[22]], null);
            watchers[28] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.mail_was_sent"];
            }// end function
            , {change:true}, [bindings[21]], null);
            watchers[31] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.saving_in_progress"];
            }// end function
            , {change:true}, [bindings[26]], null);
            watchers[30] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.saving_in_progress"];
            }// end function
            , {change:true}, [bindings[24]], null);
            watchers[34] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.embed"];
            }// end function
            , {change:true}, [bindings[30]], null);
            watchers[35] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.embed_plain"];
            }// end function
            , {change:true}, [bindings[31]], null);
            watchers[32] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.embed"];
            }// end function
            , {change:true}, [bindings[27]], null);
            watchers[33] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.saving_in_progress"];
            }// end function
            , {change:true}, [bindings[29]], null);
            watchers[36] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.embed_html"];
            }// end function
            , {change:true}, [bindings[32]], null);
            watchers[37] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.saved_products"];
            }// end function
            , {change:true}, [bindings[33]], null);
            watchers[43] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.no_auth_login_notice"];
            }// end function
            , {change:true}, [bindings[45]], null);
            watchers[44] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.username"];
            }// end function
            , {change:true}, [bindings[46]], null);
            watchers[49] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.login"];
            }// end function
            , {change:true}, [bindings[50]], null);
            watchers[48] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.password"];
            }// end function
            , {change:true}, [bindings[48]], null);
            watchers[63] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.no_auth_no_saved_products"];
            }// end function
            , {change:true}, [bindings[55]], null);
            watchers[62] = new FunctionReturnWatcher("getString", target, function () : Array
            {
                return ["confomat7", "save_share.auth_no_saved_products"];
            }// end function
            , {change:true}, [bindings[55]], null);
            watchers[18] = new PropertyWatcher("mail_form", {propertyChange:true}, [bindings[17]], propertyGetter);
            watchers[19] = new PropertyWatcher("width", {widthChanged:true}, [bindings[17]], null);
            watchers[39] = new PropertyWatcher("_selectionModel", {propertyChange:true}, [bindings[38], bindings[39], bindings[54]], propertyGetter);
            watchers[59] = new PropertyWatcher("productTotalCount", {pageChanged:true}, [bindings[54]], null);
            watchers[40] = new PropertyWatcher("products", {pageChanged:true}, [bindings[38]], null);
            watchers[56] = new PropertyWatcher("productList", {propertyChange:true}, [bindings[52], bindings[53], bindings[57], bindings[58], bindings[59], bindings[60]], propertyGetter);
            watchers[58] = new PropertyWatcher("height", {heightChanged:true}, [bindings[53], bindings[60]], null);
            watchers[69] = new PropertyWatcher("width", {widthChanged:true}, [bindings[59]], null);
            watchers[57] = new PropertyWatcher("y", {yChanged:true}, [bindings[52], bindings[58]], null);
            watchers[66] = new PropertyWatcher("x", {xChanged:true}, [bindings[57]], null);
            watchers[25] = new PropertyWatcher("mailSendInProgress", {propertyChange:true}, [bindings[18]], propertyGetter);
            watchers[4] = new PropertyWatcher("palette", {propertyChange:true}, [bindings[4], bindings[5], bindings[6], bindings[34], bindings[35], bindings[36], bindings[42], bindings[43], bindings[44], bindings[57], bindings[58]], propertyGetter);
            watchers[5] = new PropertyWatcher("width", {widthChanged:true}, [bindings[4], bindings[5], bindings[6], bindings[34], bindings[35], bindings[36], bindings[42], bindings[43], bindings[44]], null);
            watchers[68] = new PropertyWatcher("y", {yChanged:true}, [bindings[58]], null);
            watchers[67] = new PropertyWatcher("x", {xChanged:true}, [bindings[57]], null);
            watchers[6] = new PropertyWatcher("shareTabs", {propertyChange:true}, [bindings[7]], propertyGetter);
            watchers[10] = new PropertyWatcher("shareViews", {propertyChange:true}, [bindings[11], bindings[23], bindings[25], bindings[28]], propertyGetter);
            watchers[11] = new PropertyWatcher("width", {widthChanged:true}, [bindings[11], bindings[23], bindings[25], bindings[28]], null);
            watchers[53] = new PropertyWatcher("password", {propertyChange:true}, [bindings[51]], propertyGetter);
            watchers[54] = new PropertyWatcher("text", {change:false, textChanged:true}, [bindings[51]], null);
            watchers[23] = new PropertyWatcher("txtTo", {propertyChange:true}, [bindings[18]], propertyGetter);
            watchers[24] = new PropertyWatcher("isValid", {validationChange:true}, [bindings[18]], null);
            watchers[50] = new PropertyWatcher("username", {propertyChange:true}, [bindings[51]], propertyGetter);
            watchers[51] = new PropertyWatcher("text", {change:false, textChanged:true}, [bindings[51]], null);
            watchers[42] = new PropertyWatcher("showLogin", {propertyChange:true}, [bindings[41]], propertyGetter);
            watchers[0] = new PropertyWatcher("loginColor", {propertyChange:true}, [bindings[0], bindings[2]], propertyGetter);
            watchers[21] = new PropertyWatcher("txtFrom", {propertyChange:true}, [bindings[18]], propertyGetter);
            watchers[22] = new PropertyWatcher("isValid", {validationChange:true}, [bindings[18]], null);
            watchers[38] = new PropertyWatcher("resizeProductList", {propertyChange:true}, [bindings[37]], propertyGetter);
            watchers[1] = new PropertyWatcher("login", {propertyChange:true}, [bindings[1], bindings[47], bindings[49]], propertyGetter);
            watchers[45] = new PropertyWatcher("width", {widthChanged:true}, [bindings[47], bindings[49]], null);
            watchers[46] = new PropertyWatcher("loginButton", {propertyChange:true}, [bindings[47], bindings[49]], propertyGetter);
            watchers[47] = new PropertyWatcher("width", {widthChanged:true}, [bindings[47], bindings[49]], null);
            watchers[60] = new PropertyWatcher("user", {propertyChange:true}, [bindings[55]], propertyGetter);
            watchers[61] = new PropertyWatcher("isAuthentificated", {propertyChange:true}, [bindings[55]], null);
            watchers[64] = new PropertyWatcher("noProducts", {propertyChange:true}, [bindings[56]], propertyGetter);
            watchers[65] = new PropertyWatcher("width", {widthChanged:true}, [bindings[56]], null);
            watchers[41].updateParent(target);
            watchers[13].updateParent(target);
            watchers[13].addChild(watchers[14]);
            watchers[13].addChild(watchers[20]);
            watchers[2].updateParent(target);
            watchers[3].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[3]);
            watchers[7].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[7]);
            watchers[8].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[8]);
            watchers[9].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[9]);
            watchers[12].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[12]);
            watchers[15].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[15]);
            watchers[17].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[17]);
            watchers[16].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[16]);
            watchers[27].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[27]);
            watchers[26].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[26]);
            watchers[29].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[29]);
            watchers[28].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[28]);
            watchers[31].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[31]);
            watchers[30].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[30]);
            watchers[34].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[34]);
            watchers[35].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[35]);
            watchers[32].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[32]);
            watchers[33].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[33]);
            watchers[36].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[36]);
            watchers[37].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[37]);
            watchers[43].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[43]);
            watchers[44].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[44]);
            watchers[49].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[49]);
            watchers[48].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[48]);
            watchers[63].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[63]);
            watchers[62].parentWatcher = watchers[2];
            watchers[2].addChild(watchers[62]);
            watchers[18].updateParent(target);
            watchers[18].addChild(watchers[19]);
            watchers[39].updateParent(target);
            watchers[39].addChild(watchers[59]);
            watchers[39].addChild(watchers[40]);
            watchers[56].updateParent(target);
            watchers[56].addChild(watchers[58]);
            watchers[56].addChild(watchers[69]);
            watchers[56].addChild(watchers[57]);
            watchers[56].addChild(watchers[66]);
            watchers[25].updateParent(target);
            watchers[4].updateParent(target);
            watchers[4].addChild(watchers[5]);
            watchers[4].addChild(watchers[68]);
            watchers[4].addChild(watchers[67]);
            watchers[6].updateParent(target);
            watchers[10].updateParent(target);
            watchers[10].addChild(watchers[11]);
            watchers[53].updateParent(target);
            watchers[53].addChild(watchers[54]);
            watchers[23].updateParent(target);
            watchers[23].addChild(watchers[24]);
            watchers[50].updateParent(target);
            watchers[50].addChild(watchers[51]);
            watchers[42].updateParent(target);
            watchers[0].updateParent(target);
            watchers[21].updateParent(target);
            watchers[21].addChild(watchers[22]);
            watchers[38].updateParent(target);
            watchers[1].updateParent(target);
            watchers[1].addChild(watchers[45]);
            watchers[46].updateParent(target);
            watchers[46].addChild(watchers[47]);
            watchers[60].updateParent(target);
            watchers[60].addChild(watchers[61]);
            watchers[64].updateParent(target);
            watchers[64].addChild(watchers[65]);
            return;
        }// end function

        public static function init(param1:IFlexModuleFactory) : void
        {
            SharePanel.watcherSetupUtil = new _net_sprd_modules_share_SharePanelWatcherSetupUtil;
            return;
        }// end function

    }
}
