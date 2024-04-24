package mini.asaas

import grails.converters.JSON
import groovy.json.JsonSlurper
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.client.RestTemplate

class CepController {

    def fetchCep() {
        def cep = params.cep.toString()
        def apiURL = "https://viacep.com.br/ws/" + cep + "/json/"

        println("Informações do formulário " + params.toString())

        try {
            ResponseEntity<String> response = new RestTemplate().getForEntity(apiURL, String)

            if (response.statusCode == HttpStatus.OK) {
                def data = new JsonSlurper().parseText(response.body)

                println("Informações da API " + data)

                if (data.erro) {
                    flash.data = new JSON(
                            cep: cep,
                            name: params.name,
                            cpf: params.cpf,
                            phone: params.phone
                    ).target

                    flash.error = true

                    return redirect(uri: '/')
                }

                flash.data = new JSON(
                        cep: cep,
                        name: params.name,
                        cpf: params.cpf,
                        phone: params.phone,
                        street: data.logradouro,
                        city: data.localidade,
                        neighborhood: data.bairro,
                        state: data.uf
                ).target

                return redirect(uri: '/')
            }
        } catch (Exception ignored) {
            flash.data = new JSON(
                    cep: cep,
                    name: params.name,
                    cpf: params.cpf,
                    phone: params.phone
            ).target

            flash.unknownError = true;
            redirect(uri: '/')
        }
    }
}
