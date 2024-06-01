export const modalConfig = {
  pageName:"department",
  header: {
    newTitle: '新增部门',
    editTitle: '编辑部门'
  },
  formItems: [
    {
      type: 'input',
      prop: 'name',
      label: '部门名称',
      placeholder: '请输入部门名称'
      // initialValue: '' //初始化值
    },
    {
      type: 'input',
      prop: 'leader',
      label: '部门领导',
      placeholder: '请输入领导名称'
      // initialValue: 'bbb'
    },
    {
      type: 'select',
      label: '上级部门',
      prop: 'parentId',
      placeholder: '请选择上级部门',
      options: [] as any
      // 此处一万头草泥马
    }
  ]
}