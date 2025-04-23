--This is a slightly old library I originally made to make easing bullets and sprites in Create Your Frisk easier, but I ported it over to work with CelLua buttons instead!
local self = {}
local moving = {}

function self.linear(s,e,t)
	return s+(e-s)*t
end

function self.easeinout(s,e,t)
	return s+(e-s)*(-math.cos(t*math.pi)+1)*0.5
end

function self.easein(s,e,t)
	return s+(e-s)*(-math.cos(t*math.pi*0.5)+1)
end

function self.easeout(s,e,t)
	return s+(e-s)*(math.sin(t*math.pi*0.5))
end

function self.easeoutin(s,e,t)
	if t < 0.5 then
		return self.easeout(s,s+(e-s)*0.5,t*2)
	else
		return self.easein(s+(e-s)*0.5,e,(t-0.5)*2)
	end
end

function self.bouncein(s,e,t)
	return self.bounceout(e,s,1-t)
end

function self.bounceout(s,e,t)
	local scale = 1
	local offset = -1/3
	local reps = 0
	while (t-(offset+2/3*scale) > 0 and reps < 25) do
		offset = offset+2/3*scale
		scale = scale*0.5
		reps = reps + 1
	end
	t = t-offset
	return s+(e-s)*(1-math.sin(t*math.pi*1.5/scale)*scale)
end

function self.bounceinout(s,e,t)
	if t < 0.5 then
		return self.bouncein(s,s+(e-s)*0.5,t*2)
	else
		return self.bounceout(s+(e-s)*0.5,e,(t-0.5)*2)
	end
end

function self.lightbouncein(s,e,t)
	return self.lightbounceout(e,s,1-t)
end

function self.lightbounceout(s,e,t)
	local scale = 1
	local offset = -1/3
	local reps = 0
	while (t-(offset+2/3*scale) > 0 and reps < 25) do
		offset = offset+2/3*scale
		scale = scale*0.5
		reps = reps + 1
	end
	t = t-offset
	return s+(e-s)*(1-math.sin(t*math.pi*1.5/scale)*scale^2)
end

function self.lightbounceinout(s,e,t)
	if t < 0.5 then
		return self.lightbouncein(s,s+(e-s)*0.5,t*2)
	else
		return self.lightbounceout(s+(e-s)*0.5,e,(t-0.5)*2)
	end
end

function self.stronginout(s,e,t)
	return s+(e-s)*(-math.cos(self.easeinout(0,1,t)*math.pi)+1)*0.5
end

function self.strongin(s,e,t)
	return s+(e-s)*(-math.cos(self.easein(0,1,t)*math.pi*0.5)+1)
end

function self.strongout(s,e,t)
	return s+(e-s)*(math.sin(self.easeout(0,1,t)*math.pi*0.5))
end

function self.strongoutin(s,e,t)
	if t < 0.5 then
		return self.strongout(s,s+(e-s)*0.5,t*2)
	else
		return self.strongin(s+(e-s)*0.5,e,(t-0.5)*2)
	end
end

function self.gentlein(s,e,t)
	return s+(e-s)*(math.sin(self.easein(0,1,t)*math.pi*0.5))
end

function self.gentleout(s,e,t)
	return s+(e-s)*(-math.cos(self.easeout(0,1,t)*math.pi)+1)*0.5
end

function self.gentleoutin(s,e,t)
	if t < 0.5 then
		return self.easeout(s,s+(e-s)*0.5,self.easeinout(0,1,t)*2)
	else
		return self.easein(s+(e-s)*0.5,e,(self.easeinout(0,1,t)-0.5)*2)
	end
end

function self.taninout(s,e,t)
	return s+(e-s)*(2*t-(math.tan((t-0.5)*math.pi/2)/2+0.5))
end

function self.tanoutin(s,e,t)
	return s+(e-s)*(math.tan((t-0.5)*math.pi/2)/2+0.5)
end

function self.sharpinout(s,e,t)
	return s+(e-s)*(1-math.sin(math.tan(math.cos(t*math.pi))))*0.5
end

function self.sharpin(s,e,t)
	return s+(e-s)*(1-math.sin(math.tan(math.cos(t*math.pi*0.5))))
end

function self.sharpout(s,e,t)
	return s+(e-s)*math.sin(math.tan(math.sin(t*math.pi*0.5)))
end

function self.sharpoutin(s,e,t)
	if t < 0.5 then
		return self.sharpout(s,s+(e-s)*0.5,t*2)
	else
		return self.sharpin(s+(e-s)*0.5,e,(t-0.5)*2)
	end
end

--easing formulas below are courtesy of https://easings.net/

function self.backinout(s,e,t)
	local c1 = 1.70158;
	local c2 = c1 * 1.525;
	if t < 0.5 then
	    return s+(e-s)*(((2 * t)^2 * ((c2 + 1) * 2 * t - c2)) / 2)
	else
	    return s+(e-s)*(((2 * t - 2)^2 * ((c2 + 1) * (t * 2 - 2) + c2) + 2) / 2)
	end
end

function self.backin(s,e,t)
	local c1 = 1.70158;
	local c3 = c1 + 1;
	return s+(e-s)*(c3 * t * t * t - c1 * t * t)
end

function self.backout(s,e,t)
	local c1 = 1.70158;
	local c3 = c1 + 1;
	return s+(e-s)*(1 + c3 * (t - 1)^3 + c1 * (t - 1)^2)
end

function self.elasticinout(s,e,t)
	local c5 = (2 * math.pi) / 4.5
	if t == 0 then return s elseif t == 1 then return e end
	if t < 0.5 then
		return s+(e-s)*(-(2^(20 * t - 10) * math.sin((20 * t - 11.125) * c5)) / 2)
	else
		return s+(e-s)*((2^(-20 * t + 10) * math.sin((20 * t - 11.125) * c5)) / 2 + 1)
	end
end

function self.elasticin(s,e,t)
	local c4 = (2 * math.pi) / 3;
	return t == 0 and s or t == 1 and e or s+(e-s)*(-(2^(10 * t - 10)) * math.sin((t * 10 - 10.75) * c4))
end

function self.elasticout(s,e,t)
	local c4 = (2 * math.pi) / 3;
	return t == 0 and s or t == 1 and e or s+(e-s)*(2^(-10 * t) * math.sin((t * 10 - 0.75) * c4) + 1)
end

--moves a button automatically, according to the easing mode you input for mode (assuming you are calling self.Update every frame),
--mode should just be the name of one of the functions above, minus the "self." 
--if framebased is true, t is in frames; otherwise, it is in seconds.
--func is a function that will be called when the interpolation ends, useful for staring another interpolation automatically.

function self.MoveObj(obj,x,y,t,mode,func,alwaysfunc,framebased)
	table.insert(moving,1,{obj=obj,mode=mode,tx=obj.x+x,ty=obj.y+y,sx=obj.x,sy=obj.y,t=t,ct=0,fb=framebased,endfunc=func,alwaysfunc=alwaysfunc})
end

function self.MoveObjTo(obj,x,y,t,mode,func,alwaysfunc,framebased)
	table.insert(moving,1,{obj=obj,mode=mode,tx=x,ty=y,sx=obj.x,sy=obj.y,t=t,ct=0,fb=framebased,endfunc=func,alwaysfunc=alwaysfunc})
end

--call every frame for automatic interpolation

function self.Update(dt)
	for i=#moving,1,-1 do
		local m = moving[i]
		if m.fb then
			m.ct = math.min(m.ct + 1,m.t)
			local newx,newy = self[m.mode](m.sx,m.tx,m.ct/m.t),self[m.mode](m.sy,m.ty,m.ct/m.t)
			m.obj.x,m.obj.y = newx,newy
			if m.alwaysfunc then m.alwaysfunc(m.obj) end
			if m.ct == m.t then
				table.remove(moving,i)
				if m.endfunc then m.endfunc(m.obj) end
			end
		else
			m.ct = math.min(m.ct + dt,m.t)
			local newx,newy = self[m.mode](m.sx,m.tx,m.ct/m.t),self[m.mode](m.sy,m.ty,m.ct/m.t)
			m.obj.x,m.obj.y = newx,newy
			if m.alwaysfunc then m.alwaysfunc(m.obj) end
			if m.ct == m.t then
				table.remove(moving,i)
				if m.endfunc then m.endfunc(m.obj) end
			end
		end
	end
end

--THOUGH YOU LOOK AT WHERE IT WAS
--DON'T BE LOSING FAITH BECAUSE
--I WILL GRANT YOU ONE KEY
--CAN YOU PEOPLE FIND ME 
--SVRXQVNCRUZPUkVJVFdBU05U

return self