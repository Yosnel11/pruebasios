<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page
	import="net.bank2illa.common.*, net.bank2illa.connectors.*, org.json.*, java.util.*, jakarta.servlet.http.Cookie"%>
<!doctype html>
<html lang="en">
<head>
<!-- Required meta tags -->
<meta charset="UTF-8"/>
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no, shrink-to-fit=no, height=device-height, viewport-fit=cover">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="icon" type="image/png" href="favicon.ico">

<!-- CSS -->
<link rel="stylesheet" href="css/animate.css">
<link rel="stylesheet" href="css/bootstrap.min.css">
<link rel="stylesheet" href="css/bank2illa_css.css">
<link rel="stylesheet" href="css/font.css">

<!-- IOS -->
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="apple-mobile-web-app-status-bar-style" content="default">

<link rel="apple-touch-icon" href="img/icons/icon-192x192.png">

<link rel="apple-touch-icon" sizes="192x192"
	href="img/icons/icon-192x192.png">
<link rel="apple-touch-icon" sizes="384x384"
	href="img/icons/icon-384x384.png">
<link rel="apple-touch-icon" sizes="512x512"
	href="img/icons/icon-512x512.png">

<!-- iPhone Xs Max (1242px x 2688px) --> 
	<link rel="apple-touch-startup-image" media="(device-width: 414px) and (device-height: 896px) and (-webkit-device-pixel-ratio: 3)" href="img/icons-ios/apple-launch-1242x2688.png"> 
	<!-- iPhone Xr (828px x 1792px) --> 
	<link rel="apple-touch-startup-image" media="(device-width: 414px) and (device-height: 896px) and (-webkit-device-pixel-ratio: 2)" href="img/icons-ios/apple-launch-828x1792.png"> 
	<!-- iPhone X, Xs (1125px x 2436px) --> 
	<link rel="apple-touch-startup-image" media="(device-width: 375px) and (device-height: 812px) and (-webkit-device-pixel-ratio: 3)" href="img/icons-ios/apple-launch-1125x2436.png"> 
    <!-- iPhone 8, 7, 6s, 6 (750px x 1334px) -->
    <link rel="apple-touch-startup-image" media="(device-width: 375px) and (device-height: 667px) and (-webkit-device-pixel-ratio: 2)" href="img/icons-ios/apple-launch-750x1334.png">
    <!-- iPhone 8 Plus, 7 Plus, 6s Plus, 6 Plus (1242px x 2208px) -->
    <link rel="apple-touch-startup-image" media="(device-width: 414px) and (device-height: 736px) and (-webkit-device-pixel-ratio: 3)" href="img/icons-ios/apple-launch-1242x2208.png">
    <!-- iPhone 5 (640px x 1136px) -->
    <link rel="apple-touch-startup-image" media="(device-width: 320px) and (device-height: 568px) and (-webkit-device-pixel-ratio: 2)" href="img/icons-ios/apple-launch-640x1136.png">

<link rel="shortcut icon" href="favicon.ico" />
<link rel="manifest" href="manifest.webmanifest" />
<meta name="theme-color" content="#ffffff"/>

<title></title>
</head>
<%
  
  	session s = new session();
	//>>> Get Cookies
	Map<String, String> cookieMap = new HashMap();
	Cookie[] cookies = request.getCookies();
	if(cookies != null){
		for(Cookie c : cookies){
		    cookieMap.put(c.getName(), c.getValue());
		}
	}
	
	String session_delete = "";
	String session_uuid = cookieMap.get("session_uuid") == null || cookieMap.get("session_uuid").toString().equals("") ? "0" : cookieMap.get("session_uuid").toString();
	String session_token = cookieMap.get("session_token") == null || cookieMap.get("session_token").toString().equals("") ? "0" : cookieMap.get("session_token").toString();
	session_delete = s.session_delete(session_uuid, session_token);
	
  	Cookie cookie_session_uuid = new Cookie("session_uuid", "");
  	cookie_session_uuid.setPath("/");
	response.addCookie(cookie_session_uuid);
  
	Cookie cookie_session_token = new Cookie("session_token", "");
	cookie_session_token.setPath("/");
	response.addCookie(cookie_session_token);
	
	Cookie cookie_cookie_box = new Cookie("cookie_box", "");
	cookie_session_token.setPath("/");
	response.addCookie(cookie_cookie_box);
  
  %>
<body id="login_body">
	<div class="container">
	<br><br>
	
	<div class="logo_session" style="margin-bottom:5%">
	
	<div class="d-flex justify-content-center">
					<div class="">
						<img src="img/logo_inicio.png" class="img-logo" alt="Logo">
					</div>
				</div>
		
	</div>
	
	
	<div class="modal show bank2illa_modal" tabindex="-1" role="dialog" aria-labelledby="" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-body text-justify c-black">
        <span id="bank2illa_modal" class="bank2illa_modal_content" ></span>
        <br>
        <div class="text-center c-primary">
        	<a id="btn_modal_cancel" class="noloader">CERRAR</a>
        </div>
      </div>
    </div>
  </div>
</div>
		<div class="d-flex justify-content-center h-100 mt-3">
			<div class="user_card " style="margin-top:8%">
				<div class="mt-3" >
						<form id="frm_session" action="main.jsp?action=session_create"
							method="post">
							<h5 id="label_user_text" class="text-left lbl_user_text c-black mb-3 d-none">Ingresa tus datos</h5>
							
								<small id="login_msg" class="text-right c-cyan animated zoomInRight fast mb-3"></small>
								<div id="group_session_autentication_type" class="mt-3"></div>
					
							<div id="group_session_validate_type"></div>
						</form>


						<div class="row form-group text-center">
							<div class="col-6 text-right body-text-in m-block">
								<button type="button" id="btn_cancel"
									class="btn btn-secondary d-none">CANCELAR</button>
							</div>
							<div class="col-6 text-left body-text-in ">
								<button type="button" id="btn_session"
									class="btn btn-primary d-none">ACEPTAR</button>
							</div>
						</div>
						
							<br>
								
								<div class="row">
								<div class="col text-center">
										<small><a href="onboarding.jsp" class="text-yellow">&nbsp;Registro de usuario</a></small>
									</div>
									<div class="col text-center">
										<small class="text-white"><a id="btn_password_recovery" href="#">&nbsp;Cambio y desbloqueo de clave</a></small>
									</div>
								</div>
				</div>
			
			</div>
		</div>
	</div>
	
	

	
	<script src="js/jquery.min.js"></script>
	<script src="js/popper.min.js"></script>	
	<script src="js/bootstrap.min.js"></script>
	<script defer src="js/fa.js"></script>
	<script src="js/jquery.cookie.js"></script>
	<script src="js/bank2illa_app.js"></script>
	<script src="js/bowser.min.js"></script>	
	
	<script src="js/bank2illa_authorization.js"></script>
	
	 <jsp:include page="footer.jsp"/>
	
	<script>
	
	let user_role ='';
	
	var action = '<%=request.getParameter("action")%>';
  
  $(function(){
	  
    $.removeCookie('session_token', { path: '/' });
	$.removeCookie('session_uuid', { path: '/' });
	$.removeCookie('session_token');
	$.removeCookie('cookie_box');
	
	set_session_autentication_type();
	set_session_validate_type();
	
	// Añadir evento de focus a los campos específicos
	document.querySelectorAll('.focus-field').forEach(function(input) {
	    input.addEventListener('focus', showAlert);
	    input.addEventListener('focusout', hideAlert);
	    input.addEventListener('keypress', hideAlert);
	});
	
	$('#login_msg').empty();
	
	if (action == 'password_error') {
		
		$('#label_user_text').addClass('d-none');
		
		$('#login_msg').append('Asegúrate de introducir los datos correctos. Al tercer intento consecutivo inválido, tu acceso será bloqueado. Debes dirigirte a la opción cambio y desbloqueo de clave.');
		
	} else if (action == 'password_update') {
		$('#label_user_text').addClass('d-none');
		$('#login_msg').append('Tu clave ha sido actualizada exitosamente! Por favor ingresa nuevamente.');
		
	} else if (action == 'email_update') {
		$('#label_user_text').addClass('d-none');
		$('#login_msg').append('Tu correo ha sido actualizado exitosamente! Por favor ingresa nuevamente.');
		
	} else if (action == 'password_expired') {
		$('#label_user_text').addClass('d-none');
		$('#login_msg').append('Tu clave ha expirado, por favor dirígete a la opción de recuperar clave.');
		
	} else if (action == 'password_recovery') {
		$('#label_user_text').addClass('d-none');
		$('#login_msg').append('Tu clave ha sido actualizada exitosamente! Por favor ingresa nuevamente.');
	}else if (action == 'bol_session_duplicated') {
			$('#login_msg').append('Hemos detectado que exíste otra conexión activa en este momento y por su seguridad no podemos permitir el ingreso.Le recordamos que solo puede mantener una sesión activa con su usuario y clave');
			
	} else if (action == 'password_inactive') {
		$('#label_user_text').addClass('d-none');
		$('#login_msg').append('Tu acceso ha sido bloqueado. Debes dirigirte a la opción cambio y desbloqueo de clave.');

	} else if (action == 'user_recovery_sms') {
		$('#login_msg').append('La información ha sido enviada a su teléfono');
		
	} else if (action == 'user_recovery_email') {
		$('#login_msg').append('La información ha sido enviada a su correo electrónico');
		
	} else if (action == 'user_no_recovery') {
		$('#login_msg').append('Tu cuenta se encuentra inactiva');
		
	} else if (action == 'error_session') {
		$('#label_user_text').addClass('d-none');
		
		$('#login_msg').append('Tu sesión ha sido cerrada por seguridad');
		
	} else if (action == 'error_session_polar') {
		$('#label_user_text').addClass('d-none');
		
		$('#login_msg').append('El usuario no se encuentra autorizado para ingresar.');
		
	}else if (action == 'question_error') {
		$('#login_msg').append('Su cuenta ha sido bloqueada por intentos fallidos en las preguntas de seguridad. Utiliza la opción recuperar clave');
		
	} else if (action == 'expired_session') {
		$('#login_msg').append('Tu conexión ha finalizado por inactividad');
		
	} else if (action == 'user_create_invalid') {
		$('#login_msg').append('Tus datos no pudieron ser validados');
		
	} else if (action == 'user_create_error') {
		$('#label_user_text').addClass('d-none');
		$('#login_msg').append('Ha ocurrido un error creando el usuario');
		
	} else if (action == 'user_create_success') {
		$('#label_user_text').addClass('d-none');
		$('#login_msg').append('Tu usuario ha sido creado exitosamente, por favor ingresa tus datos');
		
	} else if (action == 'user_locked') {
		$('#login_msg').append('Estimado Cliente, tu usuario se encuentra temporalmente suspendido. Por favor comuniquese con el Centro de Operaciones');
		
	}else if (action == 'invalid_safecode') {
		$('#login_msg').append('Ha ingresado el código de validación incorrecto 3 veces');

	}else if (action == 'user_block') {
		$('#login_msg').append('Su usuario se encuentra bloqueado, por favor regístrese nuevamente');
		
	}else if(action == 'maintenance'){
	      $('#login_msg').append('El sistema se encuentra en mantenimiento.');
	      
    }else{
    	
    	   $('#label_user_text').removeClass('d-none');
    }
	
	$('#btn_password_recovery').click(function() {

		window.location.href = 'password_recovery.jsp';

	});
	
	$('#btn_user_create').click(function(){
		
		bank2illa_loader('on');
		window.location.href = 'user_create.jsp';
		
	});
	
	$('#btn_cancel').click(function(){
		
		bank2illa_loader('on');
		window.location.href = 'session.jsp';
		
	});
	
	$('.btn_safecode').click(function(){
		
		bank2illa_loader('on');
		$('.msg_validation').remove();
		$(this).attr('disabled', true);
		let flag_session_autentication_type = false;
		let safecode_id = '';
		flag_session_autentication_type = bank2illa_autentication_msg_safecode(session_autentication_type,flag_session_autentication_type);
		
		if(flag_session_autentication_type && bank2illa_form_validate('#frm_session')){
			
			safecode_id = bank2illa_get_autentication_type(session_autentication_type, '#frm_session');	
			safecode_id = safecode_id.toLowerCase();
			
			let template_uuid = 'abc27cc5-e299-4807-9625-4a8b04facvde';
			let data = 'template_uuid='+ template_uuid + '&safecode_detail={}';
			safecode_create(safecode_id,data);
			
		}else{		
			$('#user_'+session_autentication_type).removeAttr('readonly');
			$(this).attr('disabled', false);			
			$('.msg_validation').removeClass('c-primary');
			$('.msg_validation').addClass('c-red');
			bank2illa_loader('off');
			
		}	
		
	});
		
	$('.btn_password').click(function(){
		
		bank2illa_loader('on');
		$('.msg_validation').remove();
		$(this).attr('disabled', true);
		let flag_session_autentication_type = false;		
		
		flag_session_autentication_type = bank2illa_autentication_msg_validate(session_autentication_type,flag_session_autentication_type);
		
		if(flag_session_autentication_type){
			
				$('#lbl_user_new').addClass('d-none');
				$('#group_password').removeClass('d-none').addClass('animated zoomIn fast').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){});
				$('#btn_session').removeClass('d-none').addClass('animated zoomIn fast').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){});
				$('#btn_cancel').removeClass('d-none').addClass('animated zoomIn fast').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){});
				bank2illa_loader('off');
		
		}else{
			
			$(this).attr('disabled', false);
			bank2illa_loader('off')
		}
		
	});
	
	
	$('.btn_docid').click(function(){
	
		if(bank2illa_form_validate('#frm_docid')){								
			
			$('#lbl_user_new').addClass('d-none');
			$('#group_password').removeClass('d-none').addClass('animated zoomIn fast').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){});
			$('#btn_session').removeClass('d-none').addClass('animated zoomIn fast').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){});
			$('#btn_cancel').removeClass('d-none').addClass('animated zoomIn fast').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){});
			$(this).addClass('d-none');
			
			bank2illa_loader('off');
			
			}else{
				
				bank2illa_loader('off');
				$(this).attr('disabled', false);
				
			}
	
	});
	
	
	
	
	
	
	
	$('.btn_docid').click(function(){
		
		bank2illa_loader('on');
		$('.msg_validation').remove();
		$(this).attr('disabled', true);
		let flag_session_autentication_type = false;		
		
		flag_session_autentication_type = bank2illa_autentication_msg_validate(session_autentication_type,flag_session_autentication_type);
		
		if(flag_session_autentication_type){
			
				$('#lbl_user_new').addClass('d-none');
				$('#group_password').removeClass('d-none').addClass('animated zoomIn fast').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){});
				$('#btn_session').removeClass('d-none').addClass('animated zoomIn fast').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){});
				$('#btn_cancel').removeClass('d-none').addClass('animated zoomIn fast').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){});
				$(this).addClass('d-none');
				
				bank2illa_loader('off');
		
		}else{
			
			$(this).attr('disabled', false);
			$(this).removeClass('d-none');
			bank2illa_loader('off')
		}
		
	});
	
	 
	$('#btn_session').click(function(){
		
		bank2illa_loader('on');
		$('.msg_validation').remove();
		$(this).attr('disabled', true);
				
		if($('#pwd').val() != ''){
			
			user_id = $(this).attr('user_id');		
			session_create(user_id);
						  
		}else{
			
			bank2illa_form_msg('#pwd', 'Ingrese su clave');	  	  
			$(this).attr('disabled', false);
			bank2illa_loader('off');
		
		}
				
	});
	
	
	async function session_create(user_id) {
		user_id = $(this).attr('user_id');			
		//user_id = user_id.toLowerCase();
		var data = 'user_id=' + user_id + '&pwd=' + $('#pwd').val() + '&session_validate_type=' + session_validate_type + '&session_detail={"geolocation":['+localStorage.getItem("lng")+','+localStorage.getItem("lat")+']}';
		
	    try {
	        const response = await bank2illa_session_create(data);
	        
	        $.cookie('session_uuid', response.session.session_uuid, { expires: 365, path: '/' });
			$.cookie('session_token', response.session.session_token, { expires: 365, path: '/' });
						
			if(response.user.user_detail.user_role==="client"){
				
				if(response.session.session_detail.company_telecobro!==undefined &&response.session.session_detail.company_telecobro==="1" ){
				
					window.location.href = SERVER + '/bank2illa_inventory_front/statement.jsp?action=telecobro';
				}else{
					
					window.location.href = SERVER + '/bank2illa_inventory_front/statement.jsp';
				}
				
			}else{
				window.location.href = SERVER + '/bank2illa_inventory_front/main.jsp';
				
			}
			
	    } catch (err) {

	        if (err.error) {	
	        	
	        	if (err.error.error_code == '0014') {
	        		window.location.href  ='session.jsp?action=password_inactive';
				}else if (err.error.error_code == '0003') {
					window.location.href  ='session.jsp?action=error_session';
				}else if (err.error.error_code == '0042') {
					window.location.href  ='session.jsp?action=user_block';
				}else if (err.error.error_code == '0025') {
					window.location.href  ='session.jsp?action=password_expired';
				}else if(err.error.error_code == '00078'){
					window.location.href  ='session.jsp?action=error_session_polar';
				
				}else{
					window.location.href  ='session.jsp?action=password_error';
				}

	            
	        } else {
	        	window.location.href = 'session.jsp?action=password_error';
	        }
	    }
	}
	

	function safecode_create(safecode_id, data){
		
		bank2illa_safecode_create(safecode_id, data).then(res =>  { if(res!=undefined){ 			
					
					if(res.safecode_id == (safecode_id)){
												
						$('#lbl_user_new').addClass('d-none');
						$('#group_safecode').removeClass('d-none').addClass('animated zoomIn fast').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){});					
						$('#group_btn_safecode_resend').removeClass('d-none').addClass('animated zoomIn fast').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){});
						$('#btn_session').removeClass('d-none').addClass('animated zoomIn fast').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){});
						$('#btn_cancel').removeClass('d-none').addClass('animated zoomIn fast').one('webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend', function(){});
						
						bank2illa_loader('off');
						
						
					}
			}else{
				bank2illa_alert('Ha ocurrido un error enviando el código, si el error persiste  por favor comuníquese con el área de soporte.', '');
			}
		
		bank2illa_loader('off');
		
		});
		
	}
	function set_session_autentication_type(){
		let group_row = bank2illa_user_autentication_type(session_autentication_type);
		$('#group_session_autentication_type').append(group_row);
	}	
	
	function set_session_validate_type(){
		
		let group_row = bank2illa_user_validate_type(session_validate_type,'session');		
		$('#group_session_validate_type').append(group_row);
	}	
	 
  });
  
  </script>

	
	
</body>
</html>
