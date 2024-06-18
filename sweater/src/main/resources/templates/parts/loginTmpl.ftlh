<#macro login path isRegisterForm>
    <form action="${path}" method="post">
        <div class="row mb-3">
            <label class="col-sm-1 col-form-label"> Логин: </label>
            <div class="col-sm-4">
                <input type="text" name="username" class="form-control"/>
            </div>
        </div>
        <div class="row mb-3">
            <label class="col-sm-1 col-form-label"> Пароль: </label>
            <div class="col-sm-4">
                <input type="password" name="password" class="form-control"/>
            </div>
        </div>
        <#if isRegisterForm>
            <div class="row mb-3">
                <label class="col-sm-1 col-form-label"> Почта: </label>
                <div class="col-sm-4">
                    <input type="email" name="email" class="form-control"/>
                </div>
            </div>
        </#if>
        <#if !isRegisterForm><div><a href="/registration">Регистрация</a></div></#if>
        <button type="submit" class="btn btn-primary"><#if isRegisterForm>Зарегистрироваться<#else>Вход</#if></button>
    </form>
</#macro>

<#macro logout>
    <form action="/logout" method="post">
        <button type="submit" class="btn btn-primary">Выход</button>
    </form>
</#macro>