Return-Path: <linux-sctp+bounces-749-lists+linux-sctp=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-sctp@lfdr.de
Delivered-To: lists+linux-sctp@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EA8C88AE8
	for <lists+linux-sctp@lfdr.de>; Wed, 26 Nov 2025 09:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A845A4E492C
	for <lists+linux-sctp@lfdr.de>; Wed, 26 Nov 2025 08:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B150B318143;
	Wed, 26 Nov 2025 08:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GFa7vQkd"
X-Original-To: linux-sctp@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F7631A57C
	for <linux-sctp@vger.kernel.org>; Wed, 26 Nov 2025 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146258; cv=none; b=UjW0Tt1vqR30Q4TgPKIXQ2RAdbFwg6XIuPzP+6Vq59DC2xIeh0lYLOpskWcyJ1Key7sC3He7k5rf28j/QH8wbS8mnLHB6FbfLw/g2Fc5IddaIc94pMrud39zqY6O0zDEwjjhwdgOjy8vvyVpDlCRk6Pjk5ASc+QF/2rxq98RiU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146258; c=relaxed/simple;
	bh=ASqx3xWPQILVdmK7Ru3KczkfE5BXp+h8k9F3GYoUA08=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2WmeOT4SClcBWvNQ5pckBe460Lku7KTjzuP/9OsWPc9Kkg6Vs3wj9PMeeqRzimA0ZfOu/W6V2U1pqXNPq9LXjdSwblmYT1sVVZ1/NHB+BR6u+Lq+U1sxhPL3EFAV1qSt2Pmm8iavXj5QQo5L5ef9YDqNMKi0xdGf6iFZRu1gOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=GFa7vQkd; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-477770019e4so53381655e9.3
        for <linux-sctp@vger.kernel.org>; Wed, 26 Nov 2025 00:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1764146255; x=1764751055; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8utulqj/0eoFwTVbVzeVJuQFzJSaJPV84d8GEWszOv4=;
        b=GFa7vQkdGIqXke3sDXtlIfdi6CkVfQNuPJuAPcR+u6MwXfcYUHIIJ42g28Ugp3FrGc
         +PfzEwmsnfOdltFXXaTcoP5M4nKdwaYGrxBzqatZSwoaaLzoR6ntpjt77J6VwRM5mrY/
         Rlqh4mfJjVCAywHHVvKkCdQY7xpRYpoVHHbTH3PP/FbcGrZwVl3RbJ4X1E0Ln97UvMtg
         eeoX0VcwfTm/Bg6nM/W75x2dHcq3s9uQVBxiYRMZhx5p10PxD+leEnXwy88tuc+geRXB
         uQ9ujkQDMjUnMVH2le7lvCnYaJw2iuCsb3XmHD1Pv2UcMHR6imbgOyqiKjyixdjMa4R7
         VvZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764146255; x=1764751055;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8utulqj/0eoFwTVbVzeVJuQFzJSaJPV84d8GEWszOv4=;
        b=Lr5r3llQZrJ11473jV4gZWZzc5uOO5+zysVRWAE4hSkK8OBZT834L0N2vnOW2JhdO6
         TtPpf/9D/aFKfKF+1fphoSqMgh9fjagoDWzL3ZVJtgpqHfafJ2i91j9m6mFgkQXAkeRZ
         uJC9hFrjXlsRVF4hfrTRFriBvE85FTRsCKJtBf6XKfwLfyhgMjyrmP5AMa5/7820mtxj
         NXSrITZm/F2GRpcs3xO4+r780wraD/m5ZVWf4s+iAWUuyGppMNgnEopQQaha6KQ6NYg0
         7Gegy7/vfkF18ZM74E6+BZHJFKgSKeSF/thfJYdhSWWiPTMIVhou0HBtIHckOKG94ggr
         2/Qg==
X-Gm-Message-State: AOJu0Yyg5r2zbix1dkwQ0fAfQUwfbhJ6DXoThxZzIABgZa7KpyeJzcUn
	WUlFErhayQWhpZ9pvKhNqS3/hZ2RbtWEc1ZUfu/92lAs8enoNl8qfMI8xCQEBOTYN88=
X-Gm-Gg: ASbGnctlxJsesodwHtaAb2QW5hGaRZwa2aWs1Mgt1YPNygkjuJsf+lo89/Tsn1qOGuK
	RC2f5jig/ap63XtUGJeNqx7k5elx31VpP4HAiGz7XyaFleqabIQcMKSnWIa8Ub3LgaQdyzWG7us
	L3alH+L6SKwEVxSyxj32zWW6SR2zGRZVNBL6uWPmH+2rYZkOb4sslf6X4kiV5my4wRP5SP47ohF
	peA4wamNXZ82pRmmw4/bkd4ONtg+tmzurM7fWGwM4l0UVvV8keTDbEojDJuhJtBTbjGMIUGO847
	REkIArlDs+tiOJ2NBnMLJtPtFtArGm+xmQe8165uUPrcCn9SwWkvJ8th1IhWFef6+ZIHKTvmpOa
	4WYVILbkirqaBV3DbNuMK26Dmm2Oe0KsA9s/KQmhXYVafSKJJSKVrhTUPW7Be2hX7dVidYLCHd6
	OoP9KFjDPSdmNc530=
X-Google-Smtp-Source: AGHT+IGRJ2/pqR/Hf0lm57sCpUP9yqTnnrA5zicFoy+l7UzHAtYJd+zRJNx2T4yxsLMeeUE3d/bsUQ==
X-Received: by 2002:a05:600c:154e:b0:45d:d8d6:7fcc with SMTP id 5b1f17b1804b1-47904b24920mr58197045e9.27.1764146254959;
        Wed, 26 Nov 2025 00:37:34 -0800 (PST)
Received: from localhost ([41.210.159.101])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-479053023d4sm34710365e9.15.2025.11.26.00.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 00:37:34 -0800 (PST)
Date: Wed, 26 Nov 2025 11:37:29 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-sctp@vger.kernel.org
Subject: Re: [bug report] net/sctp: convert sctp_getsockopt_peeloff_common()
 to FD_PREPARE()
Message-ID: <aSa8SXDUZHq62XuB@stanley.mountain>
References: <aSa7l8aK1cHv1GEI@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-sctp@vger.kernel.org
List-Id: <linux-sctp.vger.kernel.org>
List-Subscribe: <mailto:linux-sctp+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-sctp+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSa7l8aK1cHv1GEI@stanley.mountain>

Similar warning in sock_map_fd()

net/socket.c:510 sock_map_fd() warn: passing freed memory 'sock' (line 508)

net/socket.c
   504  static int sock_map_fd(struct socket *sock, int flags)
   505  {
   506          int fd;
   507  
   508          fd = FD_ADD(flags, sock_alloc_file(sock, flags, NULL));
                                                   ^^^^
Freed on error.

   509          if (fd < 0)
   510                  sock_release(sock);
                        ^^^^^^^^^^^^^^^^^^
double freed.

   511          return fd;
   512  }

regards,
dan carpenter

