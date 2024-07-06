<#import "parts/commonTmpl.ftlh" as c>

<@c.page>
    <h4 class="m-3">${username}</h4>
    <#if message1??>
        <div class="alert alert-${messageType1}" role="alert">
            ${message1}
        </div>
    </#if>
    <#if message2??>
        <div class="alert alert-${messageType2}" role="alert">
            ${message2}
        </div>
    </#if>
    <div class="card card-body">
        <form method="post">
            <h6 class="mb-3">Измененение пароля:</h6>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label"> Введите старый пароль: </label>
                <div class="col-sm-4">
                    <input type="password" name="oldPassword" class="form-control"/>
                </div>
            </div>
            <div class="row mb-3">
                <label class="col-sm-2 col-form-label"> Введите новый пароль: </label>
                <div class="col-sm-4">
                    <input type="password" name="newPassword" class="form-control"/>
                </div>
            </div>
            <h6 class="mb-3">Измененение почты:</h6>
            <div class="row mb-3">
                <label class="col-sm-1 col-form-label"> Почта: </label>
                <div class="col-sm-5">
                    <input type="email" name="email" class="form-control" value="${email!}"/>
                </div>
            </div>
            <button type="submit" class="btn btn-primary">Сохранить изменения</button>
        </form>
    </div>
</@c.page>