<#import "parts/commonTmpl.ftlh" as c>

<@c.page>
    <form method="get" action="/main" class="form-inline m-2">
        <label><input class="form-control mb-2 mr-sm-2" type="text" name="filter" value="${filter!}" placeholder="Введите тег"></label>
        <button type="submit" class="btn btn-primary ms-2">Найти</button>
    </form>

    <button class="btn btn-primary mb-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
        Добавить новое сообщение
    </button>
    <div class="collapse" id="collapseExample">
        <div class="card card-body">
            <form method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <input class="form-control" type="text" name="text" placeholder="Введите сообщение" />
                </div>
                <div class="mb-3">
                    <input class="form-control" type="text" name="tag" placeholder="Тэг">
                </div>
                <div class="mb-3">
                    <input class="form-control" type="file">
                </div>
                <div class="mb-3">
                    <button class="btn btn-primary" type="submit">Добавить</button>
                </div>
            </form>
        </div>
    </div>

    <#list messages as message>
        <div class="card my-3" style="width: 25rem;">
            <div class="card-header text-end">
                ${message.authorName}
            </div>
            <div>
                <#if message.filename??>
                    <img src="/img/${message.filename}" class="card-img-bottom">
                </#if>
            </div>
            <div class="m-2">
                <h6><i>${message.tag}</i></h6>
                ${message.text}
            </div>
        </div>
    <#else>
        No message
    </#list>
</@c.page>