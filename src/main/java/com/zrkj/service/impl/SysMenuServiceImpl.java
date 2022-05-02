package com.zrkj.service.impl;

import com.zrkj.mapper.SysMenuMapper;
import com.zrkj.model.SysMenu;
import com.zrkj.service.SysMenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SysMenuServiceImpl implements SysMenuService {

    @Autowired
    private SysMenuMapper sysMenuMapper;

    @Override
    public List<SysMenu> selectList() {
        return sysMenuMapper.selectList();
    }
}
