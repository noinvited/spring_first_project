<#import "parts/commonTmpl.ftlh" as c>

<@c.page>
    <form method="get" action="/main" class="form-inline m-2">
        <label><input class="form-control mb-2 mr-sm-2" type="text" name="filter" value="${filter!}" placeholder="Введите тег"></label>
        <button type="submit" class="btn btn-primary ms-2">Найти</button>
    </form>

    <button class="btn btn-primary mb-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
        Добавить новое сообщение
    </button>
    <div class="collapse <#if message??>show</#if>" id="collapseExample">
        <div class="card card-body">
            <form method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <input class="form-control ${(textError??)?string('is-invalid', '')}"
                           value="<#if message??>${message.text}</#if>" type="text" name="text" placeholder="Введите сообщение" />
                    <#if textError??>
                        <div class="invalid-feedback">
                            ${textError}
                        </div>
                    </#if>
                </div>
                <div class="mb-3">
                    <input class="form-control ${(tagError??)?string('is-invalid', '')}"
                           value="<#if message??>${message.tag}</#if>" type="text" name="tag" placeholder="Тэг">
                    <#if tagError??>
                        <div class="invalid-feedback">
                            ${tagError}
                        </div>
                    </#if>
                </div>
                <div class="mb-3">
                    <input class="form-control" type="file" name="file">
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
        <br>No message
    </#list>
</@c.page>