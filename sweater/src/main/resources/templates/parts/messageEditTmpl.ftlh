<#macro edit isEditForm>
    <#if message?? || !isEditForm>
        <button class="btn btn-primary mb-3" type="button" data-bs-toggle="collapse" data-bs-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
            <#if !isEditForm> Добавить новое сообщение <#else> Редактировать сообщение </#if>
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
                    <input type="hidden" name="id" value="<#if message??>${message.id}</#if>">
                    <input type="hidden" name="isEditForm" value="${isEditForm?c}">
                    <div class="mb-3">
                        <button class="btn btn-primary" type="submit">
                            <#if !isEditForm> Добавить <#else> Сохранить </#if>
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </#if>


</#macro>