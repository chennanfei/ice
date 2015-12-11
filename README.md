##Intro
Ice provides a birds-eye view of our large and complex cloud landscape from a usage and cost perspective.  Cloud resources are dynamically provisioned by dozens of service teams within the organization and any static snapshot of resource allocation has limited value.  The ability to trend usage patterns on a global scale, yet decompose them down to a region, availability zone, or service team provides incredible flexibility. Ice allows us to quantify our AWS footprint and to make educated decisions regarding reservation purchases and reallocation of resources.

Ice is a Grails project. It consists of three parts: processor, reader and UI. Processor processes the Amazon detailed billing file into data readable by reader. Reader reads data generated by processor and renders them to UI. UI queries reader and renders interactive graphs and tables in the browser.

##What it does
Ice communicates with AWS Programmatic Billing Access and maintains knowledge of the following key AWS entity categories:
- Accounts
- Regions
- Services (e.g. EC2, S3, EBS)
- Usage types (e.g. EC2 - m1.xlarge)
- Cost and Usage Categories (On-Demand, Reserved, etc.)
The UI allows you to filter directly on the above categories to custom tailor your view.

In addition, Ice supports the definition of Application Groups. These groups are explicitly defined collections of resources in your organization. Such groups allow usage and cost information to be aggregated by individual service teams within your organization, each consisting of multiple services and resources. Ice also provides the ability to email weekly cost reports for each Application Group showing current usage and past trends.

When representing the cost profile for individual resources, Ice will factor the depreciation schedule into your cost contour, if so desired.  The ability to amortize one-time purchases, such as reservations, over time allows teams to better evaluate their month-to-month cost footprint.

## 准备工作
1. 访问AWS console，在"安全 & 身份 > IAM > 用户 > {用户名}"下创建访问密钥
2. S3管理页面，创建两个桶，比如billing-reports和billing-ice。给两个桶添加权限
3. 在“账单和成本管理 > 首选项”页面，选中“接收账单报告”，并将“billing-reports”填入输入框进行验证，在报告一栏选中选中前三项，最后保存首选项。详情可参考[Understanding Your Usage with Detailed Billing Reports](http://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/detailed-billing-reports.html)

## 在Docker里运行ICE
在将[smaple.properties](https://github.com/chennanfei/ice/blob/master/src/java/sample.properties)拷贝到本地命名为ice.properties，填写如下属性值

    # 组织名称，会显示在ICE的面板上
    ice.companyName=
    
    # 存放账单报告的S3桶
    ice.billing_s3bucketname=
    
    # 账单文件的前缀，比如"{acount id}-aws"，如果有多个用逗号隔开
    ice.billing_s3bucketprefix=,
    
    # 账单支付账户ID，有多个的话用逗号隔开
    ice.billing_payerAccountId=,

    # ICE处理账单会生成一些文件，这些文件存在指定桶里
    ice.work_s3bucketname=

    # 货币符号和汇率。美元对目标货币的汇率，比如美元对人民币汇率是6.4
    ice.currencySign=CNY
    ice.currency=6.4

执行下面的命令运行ICE：

    docker run -d --name billing-ice -p 8080:8080 \
        -v {dir}/ice.properties:/opt/ice/src/java/ice.properties \
        -e S3_ACCESS_KEY_ID= \
        -e S3_SECREAT_KEY_ID= \
        index.alauda.cn/alauda/ice:trusty

**S3_ACCESS_KEY_ID**：AWS IAM user的访问密钥ID

**S3_SECREAT_KEY_ID**：AWS IAM user的访问私钥ID


##License

Copyright 2014 Netflix, Inc.

Licensed under the Apache License, Version 2.0 (the “License”); you may not use this file except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an “AS IS” BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
