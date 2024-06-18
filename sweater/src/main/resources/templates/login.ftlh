<#import "parts/commonTmpl.ftlh" as c>
<#import "parts/loginTmpl.ftlh" as l>

<@c.page>
    <h5 class="m-3">Вход на страницу:</h5>
    ${message!}
    <@l.login "/login" false/>
</@c.page>