window.onload = function() {
  // Aguardar 5 segundos
  setTimeout(function() {
    // Restante do código após 5 segundos
    $("#un-lg-lg-login").focus(function() {
      $(".un-lg-gp-login").css("background-color", "#edf2f5");
      $(".un-lg-gp-password").css("background-color", "#FFF");  
    });

    $("#un-lg-lg-password").focus(function() {
      $(".un-lg-gp-login").css("background-color", "#FFF");
      $(".un-lg-gp-password").css("background-color", "#edf2f5");    
    }); 
  }, 1000); // 5000 milissegundos = 5 segundos
};

function UniDSALoginLoginOnInput(AJSName, AEvent) {
  ajaxRequest(AJSName, 'UniDSALoginLoginOnInput', ["texto=" + AEvent.target.value]);
};

function UniDSALoginPasswordOnInput(AJSName, AEvent) {
  ajaxRequest(AJSName, 'UniDSALoginPasswordOnInput', ["texto=" + AEvent.target.value]);
};

function UniDSALoginLoginNowOnClick(AJSName) {
  ajaxRequest(AJSName, 'UniDSALoginLoginNowOnClick', []);
};

function UniDSALoginCreateAccountOnClick(AJSName) {
  ajaxRequest(AJSName, 'UniDSALoginCreateAccountOnClick', []);
};

function UniDSALoginRememberMeOnClick(AJSName, AEvent) {
  var isChecked = AEvent.target.checked;
  var valueToSend = isChecked ? 'S' : 'N';
  
  ajaxRequest(AJSName, 'UniDSALoginRememberMeOnClick', ["checked=" + valueToSend]);
};

function UniDSALoginForgetPasswordOnClick(AJSName) {
  ajaxRequest(AJSName, 'UniDSALoginForgetPasswordOnClick', []);
};

function UniDSALoginLoginOnKeyDown(AJSName, AEvent) {
  if (AEvent.key === 'Enter') {
    UniDSALoginLoginOnEnter(AJSName);
  }
}

function UniDSALoginPasswordOnKeyDown(AJSName, AEvent) {
  if (AEvent.key === 'Enter') {
    UniDSALoginPasswordOnEnter(AJSName);
  }
}

function UniDSALoginLoginOnEnter(AJSName) {
  ajaxRequest(AJSName, 'UniDSALoginLoginOnEnter', []);
};

function UniDSALoginPasswordOnEnter(AJSName) {
  ajaxRequest(AJSName, 'UniDSALoginPasswordOnEnter', []);
};

function UniDSALoginPasswordOnEnter(AJSName) {
  ajaxRequest(AJSName, 'UniDSALoginPasswordOnEnter', []);
};

