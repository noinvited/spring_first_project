<#include  "securityHlpr.ftlh">

<#macro list isEditPage>
    <#list messages as message>
        <div class="card my-3" style="width: 25rem;">
            <div class="card-header text-end">
                <#if isEditPage>
                    <a href="../user-messages/${message.author.id}?isEditPage=true"> ${message.authorName} </a>
                <#else>
                    <a href="user-messages/${message.author.id}?isEditPage=false"> ${message.authorName} </a>
                </#if>
            </div>
            <div>
                <#if message.filename??>
                    <img src="/img/${message.filename}" class="card-img-bottom">
                </#if>
            </div>
            <div class="m-2">
                <h6><i>${message.tag}</i></h6>
                ${message.text}
                <#if message.author.id == currentUserId>
                    <p class="text-end">
                        <a type="button" class="btn btn-secondary"
                           <#if isEditPage>
                               href="../user-messages/${message.author.id}?message=${message.id}&isEditPage=true"
                           <#else>
                               href="user-messages/${message.author.id}?message=${message.id}&isEditPage=false"
                           </#if>
                           >
                            Изменить
                        </a>
                    </p>
                    <p class="text-end">
                        <a type="button" class="btn btn-warning"
                            <#if isEditPage>
                                href="../del-user-messages/${message.author.id}?message=${message.id}&isEditPage=true"
                            <#else>
                                href="del-user-messages/${message.author.id}?message=${message.id}&isEditPage=false"
                            </#if>
                        >
                            Удалить
                        </a>
                    </p>
                </#if>
            </div>
        </div>
    <#else>
        <br>Нет сообщений
    </#list>
</#macro>