<#import "parts/commonTmpl.ftlh" as c>

<@c.page>
    <div class="m-2"><a href="/main">Вернуться назад</a></div>
<table class="table table-striped">
    <thead>
        <tr>
            <th>Name</th>
            <th>Role</th>
            <th></th>
            <th></th>
        </tr>
    </thead>
    <tbody class="table-group-divider">
        <#list users as user>
            <tr>
                <td>${user.username}</td>
                <td><#list user.roles as role>${role.getRole()}<#sep>, </#list></td>
                <td><a href="/user/${user.id}">Изменить</a></td>
                <td><button class="btn btn-primary" type="submit">Удалить</button></td>
            </tr>
        </#list>
    </tbody>
</table>
</@c.page>