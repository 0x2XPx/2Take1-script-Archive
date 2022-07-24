local pedBones = {
  "SKEL_ROOT",
  "FB_R_Brow_Out_000",
  "SKEL_L_Toe0",
  "MH_R_Elbow",
  "SKEL_L_Finger01",
  "SKEL_L_Finger02",
  "SKEL_L_Finger31",
  "SKEL_L_Finger32",
  "SKEL_L_Finger41",
  "SKEL_L_Finger42",
  "SKEL_L_Finger11",
  "SKEL_L_Finger12",
  "SKEL_L_Finger21",
  "SKEL_L_Finger22",
  "RB_L_ArmRoll",
  "IK_R_Hand",
  "RB_R_ThighRoll",
  "SKEL_R_Clavicle",
  "FB_R_Lip_Corner_000",
  "SKEL_Pelvis",
  "IK_Head",
  "SKEL_L_Foot",
  "MH_R_Knee",
  "FB_LowerLipRoot_000",
  "FB_R_Lip_Top_000",
  "SKEL_L_Hand",
  "FB_R_CheekBone_000",
  "FB_UpperLipRoot_000",
  "FB_L_Lip_Top_000",
  "FB_LowerLip_000",
  "SKEL_R_Toe0",
  "FB_L_CheekBone_000",
  "MH_L_Elbow",
  "SKEL_Spine0",
  "RB_L_ThighRoll",
  "PH_R_Foot",
  "SKEL_Spine1",
  "SKEL_Spine2",
  "SKEL_Spine3",
  "FB_L_Eye_000",
  "SKEL_L_Finger00",
  "SKEL_L_Finger10",
  "SKEL_L_Finger20",
  "SKEL_L_Finger30",
  "SKEL_L_Finger40",
  "FB_R_Eye_000",
  "SKEL_R_Forearm",
  "PH_R_Hand",
  "FB_L_Lip_Corner_000",
  "SKEL_Head",
  "IK_R_Foot",
  "RB_Neck_1",
  "IK_L_Hand",
  "SKEL_R_Calf",
  "RB_R_ArmRoll",
  "FB_Brow_Centre_000",
  "SKEL_Neck_1",
  "SKEL_R_UpperArm",
  "FB_R_Lid_Upper_000",
  "RB_R_ForeArmRoll",
  "SKEL_L_UpperArm",
  "FB_L_Lid_Upper_000",
  "MH_L_Knee",
  "FB_Jaw_000",
  "FB_L_Lip_Bot_000",
  "FB_Tongue_000",
  "FB_R_Lip_Bot_000",
  "SKEL_R_Thigh",
  "SKEL_R_Foot",
  "IK_Root",
  "SKEL_R_Hand",
  "SKEL_Spine_Root",
  "PH_L_Foot",
  "SKEL_L_Thigh",
  "FB_L_Brow_Out_000",
  "SKEL_R_Finger00",
  "SKEL_R_Finger10",
  "SKEL_R_Finger20",
  "SKEL_R_Finger30",
  "SKEL_R_Finger40",
  "PH_L_Hand",
  "RB_L_ForeArmRoll",
  "SKEL_L_Forearm",
  "FB_UpperLip_000",
  "SKEL_L_Calf",
  "SKEL_R_Finger01",
  "SKEL_R_Finger02",
  "SKEL_R_Finger31",
  "SKEL_R_Finger32",
  "SKEL_R_Finger41",
  "SKEL_R_Finger42",
  "SKEL_R_Finger11",
  "SKEL_R_Finger12",
  "SKEL_R_Finger21",
  "SKEL_R_Finger22",
  "SKEL_L_Clavicle",
  "FACIAL_facialRoot",
  "IK_L_Foot"
}

function pedBones.GetUseAbleBones(ped)
  local bones = {}
  if(ped ~= nil)then
    for i = 1, #pedBones do     
      local bone =  entity.get_entity_bone_index_by_name(ped,pedBones[i])
      if(bone >= 0) then
        table.insert(bones, pedBones[i])
      end
    end
  end
  return bones
end

return pedBones