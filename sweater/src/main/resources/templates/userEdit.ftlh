<#import "parts/commonTmpl.ftlh" as c>

<@c.page>
    <div class="m-2"><a href="/user">Вернуться назад</a></div>
    <div class="card card-body col-sm-4">
        <form action="/user" method="post">
            <input type="text" name="username" class="form-control" value="${user.username}">
            <#list roles as role>
            <div class="mt-1">
                <label><input class="form-check-input" type="checkbox" name="${role.getRole()}" ${user.roles?seq_contains(role)?string("checked", "")}> ${role.getRole()}</label>
            </div>
            </#list>
            <input type="hidden" value="${user.id}" name="userId">
            <button type="submit" class="btn btn-primary mt-3">Сохранить</button>
        </form>
    </div>
</@c.page>