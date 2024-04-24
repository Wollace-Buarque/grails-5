<!doctype html>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Cadastro de usuário</title>
    <asset:stylesheet src="main.css"/>
</head>

<body>

<main class="container">
    <div>
        <h1 class="title">CAdastro</h1>

        <p>Para usar o serviço, preencha suas informações e um CEP no formato de 8 dígitos deve ser fornecido.</p>
    </div>

    <div class="separator"></div>

    <g:form action="fetchCep" controller="cep">
        <div class="form-grid">

            <div class="form-group">
                <label for="name">Nome completo</label>

                <input id="name" name="name" required autofocus
                       placeholder="Fulano Ciclano"
                       value="${flash.data?.name ?: ''}"
                       pattern="^(\w\w+)\s(\w+)$"/>
            </div>

            <div class="form-group">
                <label for="cpf">CPF</label>

                <input id="cpf" name="cpf" required
                       placeholder="000.000.000-00"
                       value="${flash.data?.cpf ?: ''}"
                       pattern="\d{3}\.?\d{3}\.?\d{3}-?\d{2}"/>
            </div>

            <div class="form-group">
                <label for="phone">Celular</label>

                <input id="phone" name="phone" type="tel"
                       placeholder="8190000-0000" required
                       value="${flash.data?.phone ?: ''}"/>
            </div>

            <div class="form-group">
                <label for="cep">CEP</label>

                <input id="cep" name="cep" required minlength="8" maxlength="8"
                       placeholder="00000-000"
                       value="${flash.data?.cep ?: ''}"
                       pattern="\d{5}-?\d{3}"/>
            </div>
        </div>

        <div class="form-grid">
            <g:if test="${flash.data?.street != null}">
                <div class="form-group">
                    <label for="street">Rua</label>
                    <input id="street" value="${flash.data.street}" placeholder="Rua" required/>
                </div>

                <div class="form-group">
                    <label for="city">Cidade</label>
                    <input id="city" value="${flash.data.city}" placeholder="Cidade" required/>
                </div>

                <div class="form-group">
                    <label for="neighborhood">Bairro</label>
                    <input id="neighborhood" value="${flash.data.neighborhood}" placeholder="Bairro" required/>
                </div>

                <div class="form-group">
                    <label for="state">Estado</label>
                    <input id="state" value="${flash.data.state}" placeholder="Estado" min="2" maxlength="2" required/>
                </div>
            </g:if>
        </div>

        <g:if test="${(flash.data != null && flash.data?.city != null) && (!flash.error && !flash.unknownError)}">
            <p class="success">Informações recebidas com sucesso!</p>
        </g:if>

        <g:if test="${flash.error}">
            <p class="warn">Verifique se seu CEP foi digitado corretamente.</p>
        </g:if>

        <g:if test="${flash.unknownError}">
            <p class="warn">Algum erro inesperado aconteceu.</p>
        </g:if>

        <button type="submit">Enviar dados</button>
    </g:form>
</main>

</body>
</html>
