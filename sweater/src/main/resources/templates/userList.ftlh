<#import "parts/commonTmpl.ftlh" as c>

<@c.page>
    <div class="m-2"><a href="/main">Вернуться назад</a></div>
<table class="table table-striped">
    <thead>
        <tr>
            <th>Имя</th>
            <th>Роль</th>
            <th>Статус</th>
            <th></th>
            <th></th>
        </tr>
    </thead>
    <tbody class="table-group-divider">
        <#list users as user>
            <tr>
                <td>${user.username}</td>
                <td><#list user.roles as role>${role.getRole()}<#sep>, </#list></td>
                <td><#if user.isActive()>Действующий аккаунт<#else> Заблокированный</#if></td>
                <td><a href="/user/${user.id}">Изменить</a></td>
                <td>
                    <form action="/user/delete" method="post">
                        <input type="hidden" value="${user.id}" name="userId">
                        <button class="btn btn-primary" type="submit">Удалить</button>
                    </form>
                </td>
            </tr>
        </#list>
    </tbody>
</table>
</@c.page>