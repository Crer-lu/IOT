import router from '../route/index.js'


export default{
    state:{
        userid:window.localStorage.getItem('userid')?window.localStorage.getItem('userid'):null,
        name:window.localStorage.getItem('name')?window.localStorage.getItem('name'):null,
        email:window.localStorage.getItem('email')?window.localStorage.getItem('email'):null,
        token:window.localStorage.getItem('token')?window.localStorage.getItem('token'):null,
        phone:window.localStorage.getItem('phone')?window.localStorage.getItem('phone'):null,
    },
    getters:{
        userid:(state)=>{
            if(state.userid==null){
                let sessionUser = localStorage.getItem("userid");
                if(sessionUser !=null)
                {
                    state.userid = JSON.parse(sessionUser)
                    return sessionUser
                }
            }
            return state.userid
        },
        name:(state)=>{
            if(state.name==null){
                let sessionUser = localStorage.getItem("name");
                if(sessionUser !=null)
                {
                    state.name = JSON.parse(sessionUser)
                    return sessionUser
                }
            }
            return state.name
        },
        email:(state)=>{
            if(state.email==null){
                let sessionUser = localStorage.getItem("email");
                if(sessionUser !=null)
                {
                    state.email = JSON.parse(sessionUser)
                    return sessionUser
                }
            }
            return state.email
        },
        phone:(state)=>{
            if(state.phone==null){
                let sessionUser = localStorage.getItem("phone");
                if(sessionUser !=null)
                {
                    state.phone = JSON.parse(sessionUser)
                    return sessionUser
                }
            }
            return state.phone
        },
        token:(state)=>{
            if(state.token == null)
            {
                let sessionToken = localStorage.getItem("token")
                if(sessionToken != null)
                {
                    state.token=JSON.parse(sessionToken)
                    return sessionToken
                }
            }
            return state.token
        }
    },
    mutations:{
        setUserid(state, userid){
            localStorage.setItem("userid",userid)
            state.userid=userid
        },
        setToken(state, token){
            localStorage.setItem("token",token)
            state.token=token
        },
        setEmail(state, email){
            localStorage.setItem("email",email)
            state.token=email
        },
        setUser(state, name){
            state.name=name
            localStorage.setItem("name",name)
        },
        setPhone(state, phone){
            state.phone=phone
            localStorage.setItem("phone",phone)
        },
        logout(state){
            state.userid=null
            state.name=null
            state.token=null
            state.email=null
            state.phone=null
            localStorage.removeItem("token")
            localStorage.removeItem("name")
            localStorage.removeItem("email")
            localStorage.removeItem("userid")
            localStorage.removeItem("phone")
            router.push({path:'/login', replace:true})
        }
    },
    actions:{},
}