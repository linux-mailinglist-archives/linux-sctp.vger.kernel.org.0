Return-Path: <linux-sctp-owner@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D228A7A08FE
	for <lists+linux-sctp@lfdr.de>; Thu, 14 Sep 2023 17:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240810AbjINPXL (ORCPT <rfc822;lists+linux-sctp@lfdr.de>);
        Thu, 14 Sep 2023 11:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239524AbjINPXL (ORCPT
        <rfc822;linux-sctp@vger.kernel.org>); Thu, 14 Sep 2023 11:23:11 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1759FC1
        for <linux-sctp@vger.kernel.org>; Thu, 14 Sep 2023 08:23:07 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6c0b8f42409so582548a34.0
        for <linux-sctp@vger.kernel.org>; Thu, 14 Sep 2023 08:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694704986; x=1695309786; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Oxl0ug/yVLPKUYQd73DTJjFkG9FbbND2hdWAozglsc8=;
        b=DW4GDWCFlLGjO2khKs6YCOZ0VbYZMx/bsIAIFpIJRM74gPy1e5jic/5A7ZUEXBqyYx
         uO/RQatJvjdb9v7HbD2POGyRwk9z32E5NaGQYmquWDQXg7m8MOCUdxE7PwOQp+HpxwAe
         0UTEw5a0DbpGNtUbNPKblGIKsJsAb85d0AUoW3MwpsrDYAW8DO1NLvui0oJz7HJN0wZK
         A5LV05WPef9Ac9tpAPYmABtsdmTjkL0FdXlaLVESmJ7qpaf0fBCFYi/Nv/JxqDEaBrmm
         NVDUhP8H5faTTQy0TYiKenANeKErbXfmeFy76tGc9sJfEcjkD+mzmpoF6AvolUkU3XWM
         fUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694704986; x=1695309786;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oxl0ug/yVLPKUYQd73DTJjFkG9FbbND2hdWAozglsc8=;
        b=upCyWmAgWV51ua0fKZ0sqUtrjqhkdI3LO3YFf3EM8uMrPke6Vc4Bw+dwti0mQLJJIv
         TN+UxL2BWKsCVJ3wCT08JqB97N8KdpO9e1Cb4dQIx4jFrhWELGvlb8hLC6rdMOd70PbQ
         ynCidr2vh7x8t51jmQ1l2QXpgFZVg1niuT0kuABqZkXuqkhmw6WJSxe3sg5eOTdvfUH0
         vxTEydobe6GWfvO6zr3tuxrFEHvtTSx2edVUSjbeJVZqJkmAQgsVJjM7+cioZDrLejQP
         JHKc7OaDUCAzUeH2tqgeO7Ffy/GCWU5ugRkKHb8aexK7vLQVnUPMcWoJ/wXeqAAjqMAB
         AgBg==
X-Gm-Message-State: AOJu0Yx2/3bDIhe8VcJ2vyPe57xuj8SnYvO/EmP5FQ1IMgDkrmhbzNK+
        WXA9cNIUUe4LI1BIWlbH23fXq6G9b0I=
X-Google-Smtp-Source: AGHT+IGZEix+2vRPhuDl5Ntj0E5pb1ygvyyuujNjgQZLD+tr3Rm9ZJ/DGS6rPVzhrHePEJ1Ftob23Q==
X-Received: by 2002:a9d:4d91:0:b0:6bf:29d4:1886 with SMTP id u17-20020a9d4d91000000b006bf29d41886mr6794464otk.34.1694704986319;
        Thu, 14 Sep 2023 08:23:06 -0700 (PDT)
Received: from t14s.localdomain ([2001:1284:f508:19cd:3b6:25cc:fc94:8372])
        by smtp.gmail.com with ESMTPSA id b45-20020a4a98f0000000b00565d41ba4d0sm732887ooj.35.2023.09.14.08.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 08:23:05 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
        id 15FF376E46F; Thu, 14 Sep 2023 12:23:04 -0300 (-03)
Date:   Thu, 14 Sep 2023 12:23:04 -0300
From:   Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To:     Shubh <shubhisroking@gmail.com>
Cc:     linux-sctp@vger.kernel.org, Xin Long <lucien.xin@gmail.com>
Subject: Re: [PATCH] sctp: Fix spelling mistake "tranport" -> "transport"
Message-ID: <dvxtuqgpghk7ubomxjkpnkerla473ghrc23xc2bxzosqiwsxsk@ydr23iuescvl>
References: <20230902093457.70049-1-shubhisroking@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902093457.70049-1-shubhisroking@gmail.com>
Precedence: bulk
List-ID: <linux-sctp.vger.kernel.org>
X-Mailing-List: linux-sctp@vger.kernel.org

On Sat, Sep 02, 2023 at 03:04:57PM +0530, Shubh wrote:
> Signed-off-by: Shubh <shubhisroking@gmail.com>

Hi Shubh,

Thanks for your patch but you need to post it to
netdev@vger.kernel.org. There, it can be picked up for inclusion.

Cheers,
Marcelo.
