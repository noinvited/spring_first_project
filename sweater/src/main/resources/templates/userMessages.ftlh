<#import "parts/commonTmpl.ftlh" as c>
<#import "parts/messageEditTmpl.ftlh" as m>
<#import "parts/messageListTmpl.ftlh" as l>

<@c.page>
    <div class = "container">
        <div class="row">
            <div class="col">
                <h3>${userChannel.username}</h3>
            </div>
            <div class="col text-end">
                <#if !isCurrentUser>
                    <#if !isSubscriber>
                        <a class="btn btn-primary" href="../user/subscribe/${userChannel.id}">Подписаться</a>
                    <#else>
                        <a class="btn btn-primary" href="../user/unsubscribe/${userChannel.id}">Отписаться</a>
                    </#if>
                </#if>
            </div>
        </div>
    </div>

    <div class = "container">
        <div class="row">
            <div class="col">
                <div class="card my-3">
                    <div class="card-body">
                        <div class="card-title">Подписки</div>
                        <h3 class="card-text">
                            <a href="../user/subscriptions/${userChannel.id}/list">${subscriptionsCount}</a>
                        </h3>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card my-3">
                    <div class="card-body">
                        <div class="card-title">Подписчики</div>
                        <h3 class="card-text">
                            <a href="../user/subscribers/${userChannel.id}/list">${subscribersCount}</a>
                        </h3>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <h3>Список сообщений:</h3>

    <#if isCurrentUser>
        <@m.edit true/>
    </#if>

    <@l.list true/>
</@c.page>