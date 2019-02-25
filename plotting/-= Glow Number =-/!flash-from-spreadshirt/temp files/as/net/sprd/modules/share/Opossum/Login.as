package net.sprd.modules.share.Opossum
{
    import flash.events.*;
    import flash.net.*;
    import net.sprd.api.io.xml.*;
    import net.sprd.api.resource.*;
    import net.sprd.common.logging.*;
    import net.sprd.common.logging.loggers.*;
    import net.sprd.common.utils.*;

    public class Login extends Object
    {
        private static const log:ILogger = LogContext.getLogger(this);
        private static var _processor:XMLResourceProcessor;

        public function Login()
        {
            throw new Error("Static class");
        }// end function

        public static function login(param1:String, param2:String, param3:Function = null, param4:Function = null) : void
        {
            var url:String;
            var message:String;
            var username:* = param1;
            var password:* = param2;
            var complete:* = param3;
            var fault:* = param4;
            var loader:* = new URLLoader();
            loader.dataFormat = URLLoaderDataFormat.BINARY;
            url = ConfomatConfiguration.opossumBaseUrlSecure + "/Login/login";
            var vars:* = new URLVariables();
            vars.login = username;
            vars.password = password;
            var request:* = new URLRequest(url);
            request.method = URLRequestMethod.POST;
            request.data = vars;
            var postComplete:* = function (param1:Event) : void
            {
                var payload:XML;
                var user:User;
                var e:* = param1;
                var loader:* = e.target as URLLoader;
                var response:* = processor.processResponse(loader.data);
                try
                {
                    payload = XML(loader.data).payload[0];
                }
                catch (e:Error)
                {
                    log.warn("Login data in wrong format " + e.toString());
                    if (fault)
                    {
                        fault(new LoginEvent(LoginEvent.LOGIN_ERROR));
                    }
                    return;
                }
                switch(response.status)
                {
                    case ResourceStatus.OK:
                    {
                        if (complete)
                        {
                            user = new User();
                            user.isAuthentificated = true;
                            if (payload.user != undefined)
                            {
                                if (payload.user.@id != undefined)
                                {
                                    user.id = payload.user.@id;
                                }
                                if (payload.user.username != undefined)
                                {
                                    user.username = payload.user.username;
                                }
                                if (payload.user.firstName != undefined)
                                {
                                    user.firstName = payload.user.firstName;
                                }
                                if (payload.user.surName != undefined)
                                {
                                    user.surName = payload.user.surName;
                                }
                                if (payload.user.email != undefined)
                                {
                                    user.email = payload.user.email;
                                }
                            }
                            complete(new LoginEvent(LoginEvent.LOGIN_SUCCESS, user));
                        }
                        break;
                    }
                    case ResourceStatus.FORBIDDEN:
                    {
                        log.warn("Response status: " + response.status.code + ". Response message: " + response.message);
                        log.warn(String(loader.data).replace(/<![CDATA[/g, "").replace(/]]>/g, ""));
                        if (fault)
                        {
                            fault(new LoginEvent(LoginEvent.LOGIN_FAIL));
                        }
                        break;
                    }
                    default:
                    {
                        log.warn("Response status: " + response.status.code + ". Response message: " + response.message);
                        log.warn(String(loader.data).replace(/<![CDATA[/g, "").replace(/]]>/g, ""));
                        if (fault)
                        {
                            fault(new LoginEvent(LoginEvent.LOGIN_ERROR));
                        }
                        break;
                    }
                }
                return;
            }// end function
            ;
            with ({})
            {
                {}.securityError = function (param1:SecurityErrorEvent) : void
            {
                log.warn("Security error: " + param1);
                if (fault)
                {
                    fault(new LoginEvent(LoginEvent.LOGIN_ERROR));
                }
                return;
            }// end function
            ;
            }
            with ({})
            {
                {}.securityError = function (param1:IOErrorEvent) : void
            {
                log.warn("IO error: " + param1);
                if (fault)
                {
                    fault(new LoginEvent(LoginEvent.LOGIN_ERROR));
                }
                return;
            }// end function
            ;
            }
            EventUtil.registerOnetimeListeners(loader, [Event.COMPLETE, SecurityErrorEvent.SECURITY_ERROR, IOErrorEvent.IO_ERROR], [postComplete, function (param1:SecurityErrorEvent) : void
            {
                log.warn("Security error: " + param1);
                if (fault)
                {
                    fault(new LoginEvent(LoginEvent.LOGIN_ERROR));
                }
                return;
            }// end function
            , function (param1:IOErrorEvent) : void
            {
                log.warn("IO error: " + param1);
                if (fault)
                {
                    fault(new LoginEvent(LoginEvent.LOGIN_ERROR));
                }
                return;
            }// end function
            ]);
            try
            {
                loader.load(request);
            }
            catch (error:Error)
            {
                message = "Unable to send resource " + url + ": " + error.message;
                log.warn(message);
                if (fault)
                {
                    this.fault(new LoginEvent(LoginEvent.LOGIN_ERROR));
                }
            }
            return;
        }// end function

        public static function get processor() : XMLResourceProcessor
        {
            if (!_processor)
            {
                _processor = new XMLResourceProcessor();
            }
            return _processor;
        }// end function

    }
}
