Locales['en'] = {
    ['document_deleted'] = "El documento ha sido ~g~destruido~w~.",
    ['document_delete_failed'] = "Destrucción de documento ~r~fallida~w~.",
    ['copy_from_player'] = "Has ~g~recivido~w~ una copia de un formulario.",
    ['from_copied_player'] = "Formulario ~g~copiado~w~ al jugador",
    ['could_not_copy_form_player'] = "~r~No~w~ se pudo copiar el formulario al jugador.",
    ['document_options'] = "Opciones de documentos",
    ['public_documents'] = "Documentos Públicos",
    ['job_documents'] = "Documentos de Trabajo",
    ['saved_documents'] = "Documentos archivados",
    ['close_bt'] = "Cerrar",
    ['no_player_found'] = "No se han encontrado jugadores",
    ['go_back'] = "Volver atrás",
    ['view_bt'] = "Ver",
    ['show_bt'] = "Enseñar",
    ['give_copy'] = "Entregar una copia",
    ['delete_bt'] = "Borrar",
    ['yes_delete'] = "Sí, borrar",
}

Config.Documents['en'] = {
      ["public"] = {
        {
          headerTitle = "FORMULARIO DE AFIRMACIÓN",
          headerSubtitle = "Formulario de afirmación ciudadana.",
          elements = {
            { label = "CONTENIDO DE AFIRMACIÓN", type = "textarea", value = "", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "DECLARACIÓN DEL TESTIGO",
          headerSubtitle = "Testimonio de testigos oficiales.",
          elements = {
            { label = "FECHA DE OCURENCIA", type = "input", value = "", can_be_emtpy = false },
            { label = "CONTENIDO DEL TESTIMONIO", type = "textarea", value = "", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "DECLARACIÓN DE TRANSPORTE DE VEHÍCULOS",
          headerSubtitle = "El vehículo transmite declaración hacia otro ciudadano.",
          elements = {
            { label = "NÚMERO DE PLACA", type = "input", value = "", can_be_emtpy = false },
            { label = "NOMBRE CIUDADANO", type = "input", value = "", can_be_emtpy = false },
            { label = "PRECIO ACORDADO", type = "input", value = "", can_be_empty = false },
            { label = "OTRA INFORMACIÓN", type = "textarea", value = "", can_be_emtpy = true },
          }
        },
        {
          headerTitle = "ESTADO DE DEUDA HACIA EL CIUDADANO",
          headerSubtitle = "Declaración de deuda oficial hacia otro ciudadano.",
          elements = {
            { label = "PRIMER NOMBRE DEL ACREEDOR", type = "input", value = "", can_be_emtpy = false },
            { label = "APELLIDO DEL ACREEDOR", type = "input", value = "", can_be_emtpy = false },
            { label = "CANTIDAD DEBIDA", type = "input", value = "", can_be_empty = false },
            { label = "FECHA DE VENCIMIENTO", type = "input", value = "", can_be_empty = false },
            { label = "OTRA INFORMACIÓN", type = "textarea", value = "", can_be_emtpy = true },
          }
        },
        {
          headerTitle = "DECLARACIÓN DE LIQUIDACIÓN DE DEUDA",
          headerSubtitle = "Declaración de liquidación de deuda de otro ciudadano.",
          elements = {
            { label = "PRIMER NOMBRE DEL DEUDOR", type = "input", value = "", can_be_emtpy = false },
            { label = "APELLIDO DEL DEUDOR", type = "input", value = "", can_be_emtpy = false },
            { label = "CANTIDAD DEUDA", type = "input", value = "", can_be_empty = false },
            { label = "OTRA INFORMACIÓN", type = "textarea", value = "POR LA PRESENTE DECLARO QUE EL CIUDADANO MENCIONADO ANTERIORMENTE HA COMPLETADO UN PAGO CON EL MONTO DE DEUDA MENCIONADO ANTERIORMENTE", can_be_emtpy = false, can_be_edited = false },
          }
        }
      },
      ["police"] = {
        {
          headerTitle = "PERMISO ESPECIAL DE ESTACIONAMIENTO",
          headerSubtitle = "Permiso especial de estacionamiento sin límite.",
          elements = {
            { label = "NOMBRE TITULAR", type = "input", value = "", can_be_emtpy = false },
            { label = "APELLIDO DEL TITULAR", type = "input", value = "", can_be_emtpy = false },
            { label = "VÁLIDO HASTA", type = "input", value = "", can_be_empty = false },
            { label = "INFORMACIÓN", type = "textarea", value = "EL CIUDADANO MENCIONADO ANTERIORMENTE HA SIDO OTORGADO PERMISO DE ESTACIONAMIENTO ILIMITADO EN CADA ZONA DE LA CIUDAD Y ES VÁLIDO HASTA LA FECHA DE VENCIMIENTO MENCIONADA ANTERIORMENTE.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "PERMISO DE ARMAS",
          headerSubtitle = "Permiso especial de armas proporcionado por la policía.",
          elements = {
            { label = "NOMBRE TITULAR", type = "input", value = "", can_be_emtpy = false },
            { label = "APELLIDO DEL TITULAR", type = "input", value = "", can_be_emtpy = false },
            { label = "VÁLIDO HASTA", type = "input", value = "", can_be_empty = false },
            { label = "INFORMACIÓN", type = "textarea", value = "AL CIUDADANO MENCIONADO ANTERIORMENTE SE LE PERMITE Y SE LE OTORGA UN PERMISO DE ARMAS QUE SERÁ VÁLIDO HASTA LA FECHA DE VENCIMIENTO ANTERIORMENTE MENCIONADA.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "LIMPIEZA DEL EXPEDIENTE CRIMINAL DEL CIUDADANO",
          headerSubtitle = "Registro oficial limpio, de propósito general, de antecedentes penales ciudadanos.",
          elements = {
            { label = "Nombre ciudadano/A", type = "input", value = "", can_be_emtpy = false },
            { label = "APELLIDO CIUDADANO/A", type = "input", value = "", can_be_emtpy = false },
            { label = "VÁLIDO HASTA", type = "input", value = "", can_be_empty = false },
            { label = "GRABAR", type = "textarea", value = "POR LA PRESENTE LA POLICÍA DECLARA QUE EL CIUDADANO/A MENCIONADO ANTERIORMENTE TIENE UN EXPEDIENTE CRIMINAL CLARO. ESTE RESULTADO SE GENERA A PARTIR DE LOS DATOS ENVIADOS AL SISTEMA DE REGISTRO PENAL EN LA FECHA DE FIRMA DEL DOCUMENTO.", can_be_emtpy = false, can_be_edited = false },
          }         }
      },
      ["ambulance"] = {
        {
          headerTitle = "INFORME MÉDICO - PATOLOGÍA",
          headerSubtitle = "Informe médico oficial proporcionado por un patólogo.",
          elements = {
            { label = "NOMBRE ASEGURADO", type = "input", value = "", can_be_emtpy = false },
            { label = "APELLIDO ASEGURADO", type = "input", value = "", can_be_emtpy = false },
            { label = "VÁLIDO HASTA", type = "input", value = "", can_be_empty = false },
            { label = "NOTAS MÉDICAS", type = "textarea", value = "EL CIUDADANO ASEGURADO ANTERIORMENTE FUE PROBADO POR UN FUNCIONARIO DE SALUD Y SE DETERMINÓ SALUDABLE SIN CONDICIONES DETECTADAS A LARGO PLAZO. ESTE INFORME ES VÁLIDO HASTA LA FECHA DE VENCIMIENTO ANTES MENCIONADA.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "INFORME MÉDICO - PSICOLOGÍA",
          headerSubtitle = "Informe médico oficial proporcionado por un psicólogo.",
          elements = {
            { label = "NOMBRE ASEGURADO", type = "input", value = "", can_be_emtpy = false },
            { label = "APELLIDO ASEGURADO", type = "input", value = "", can_be_emtpy = false },
            { label = "VÁLIDO HASTA", type = "input", value = "", can_be_empty = false },
            { label = "NOTAS MÉDICAS", type = "textarea", value = "EL CIUDADANO ASEGURADO ANTES MENCIONADO FUE PROBADO POR UN FUNCIONARIO DE SALUD Y DETERMINADO MENTALMENTE SALUD SEGÚN LOS ESTÁNDARES DE PSICOLOGÍA MÁS BAJOS APROBADOS. ESTE INFORME ES VÁLIDO HASTA LA FECHA DE VENCIMIENTO ANTES MENCIONADA.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "INFORME MÉDICO - ESPECIALISTA EN OJOS",
          headerSubtitle = "Informe médico oficial proporcionado por un oftalmólogo.",
          elements = {
            { label = "NOMBRE ASEGURADO", type = "input", value = "", can_be_emtpy = false },
            { label = "APELLIDO ASEGURADO", type = "input", value = "", can_be_emtpy = false },
            { label = "VÁLIDO HASTA", type = "input", value = "", can_be_empty = false },
            { label = "NOTAS MÉDICAS", type = "textarea", value = "EL CIUDADANO ASEGURADO ANTERIORMENTE FUE PROBADO POR UN FUNCIONARIO DE SALUD Y DETERMINADO CON UNA VISTA SALUDABLE Y PRECISA. ESTE INFORME ES VÁLIDO HASTA LA FECHA DE VENCIMIENTO ANTES MENCIONADA.", can_be_emtpy = false },
          }
        },
        {
          headerTitle = "MARIHUANA MÉDICA",
          headerSubtitle = "Official medical marijuana usage permit for citizens.",
          elements = {
            { label = "NOMBRE ASEGURADO", type = "input", value = "", can_be_emtpy = false },
            { label = "APELLIDO ASEGURADO", type = "input", value = "", can_be_emtpy = false },
            { label = "VÁLIDO HASTA", type = "input", value = "", can_be_empty = false },
            { label = "NOTAS MÉDICAS", type = "textarea", value = "AL CIUDADANO ASEGURADO MENCIONADO ANTERIORMENTE SE OTORGA EL PERMISO DE USO DE MARIHUANA DEBIDO A MOTIVOS MÉDICOS NO DIVULGADOS, DESPUÉS DE SER EXAMINADO A FONDO POR UN ESPECIALISTA EN SALUD. LA CANTIDAD LEGAL Y PERMITIDA QUE PUEDE TENER UN CIUDADANO NO PUEDE SER MÁS DE 100 gramos.", can_be_emtpy = false, can_be_edited = false },
          }
        },

      ["avocat"] = {
        {
          headerTitle = "LEGAL SERVICES CONTRACT",
          headerSubtitle = "Legal services contract provided by a lawyer.",
          elements = {
            { label = "CITIZEN FIRSTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "CITIZEN LASTNAME", type = "input", value = "", can_be_emtpy = false },
            { label = "VÁLIDO HASTA", type = "input", value = "", can_be_empty = false },
            { label = "INFORMATION", type = "textarea", value = "THIS DOCUMENT IS PROOF OF LEGAL REPRESANTATION AND COVERAGE OF THE AFOREMENTIONED CITIZEN. LEGAL SERVICES ARE VÁLIDO HASTA THE AFOREMENTIONED EXPIRATION DATE.", can_be_emtpy = false },
          }
        }
      }
    }
  }
