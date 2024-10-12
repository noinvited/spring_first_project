<#import "parts/commonTmpl.ftlh" as c>

<@c.page>
    <a class="btn btn-outline-primary mb-3" href="/user-messages/${user.id}">
        Вернуться назад
    </a>

    <h3 class="mb-3">${userChannel.username}</h3>
    <h5>${type}</h5>

    <ul class="list-group">
        <#list users as user>
            <li class="list-group-item">
                <a href="/user-messages/${user.id}">${user.getUsername()}</a>
            </li>
        <#else>
            Пока тут пусто...
        </#list>
    </ul>
</@c.page>